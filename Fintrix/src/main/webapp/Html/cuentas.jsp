<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*,java.text.NumberFormat,fintrix.dao.CuentaDAO,fintrix.model.Cuenta,fintrix.dao.PreferenciasDAO,fintrix.model.Preferencias,fintrix.dao.UsuarioDAO,fintrix.model.Usuario" %>
<!DOCTYPE html>

<%
    request.setCharacterEncoding("UTF-8");
    String theme = (String)session.getAttribute("theme");
    Integer usuarioId = (Integer)session.getAttribute("usuarioId");
    if (theme == null || session.getAttribute("currencyLocale") == null) {
        UsuarioDAO udao = new UsuarioDAO();
        Usuario u = null;
        if (usuarioId != null) { u = udao.obtenerPorId(usuarioId); }
        if (u == null) { List<Usuario> us = udao.listarUsuarios(); if (!us.isEmpty()) { u = us.get(0); session.setAttribute("usuarioId", u.getId()); } }
        if (u != null) {
            PreferenciasDAO pdao = new PreferenciasDAO();
            Preferencias p = pdao.obtenerPorUsuarioId(u.getId());
            theme = p.getTema(); session.setAttribute("theme", theme);
            java.util.Locale loc = pdao.getLocaleForMoneda(p.getMoneda()); session.setAttribute("currencyLocale", loc);
        }
        if (theme == null) theme = "dark";
    }
    java.util.Locale currLoc = (java.util.Locale)session.getAttribute("currencyLocale"); if (currLoc == null) currLoc = new java.util.Locale("es","CO");
    NumberFormat nf = NumberFormat.getCurrencyInstance(currLoc);
    String msg = null; String tipo = null;
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String action = request.getParameter("action");
        try {
            CuentaDAO cdao = new CuentaDAO();
            if ("create".equalsIgnoreCase(action)) {
                String nombre = request.getParameter("nombre");
                String tipoCuenta = request.getParameter("tipo");
                String saldoStr = request.getParameter("saldo_inicial");
                double saldo = saldoStr != null && saldoStr.trim().length() > 0 ? Double.parseDouble(saldoStr) : 0.0;
                if (nombre == null || nombre.trim().isEmpty()) { msg = "El nombre es obligatorio"; tipo = "warning"; }
                else if (saldo < 0) { msg = "El saldo inicial no puede ser negativo"; tipo = "warning"; }
                else if (cdao.existeNombreParaUsuario((Integer)session.getAttribute("usuarioId"), nombre.trim(), null)) { msg = "Ya existe una cuenta con ese nombre"; tipo = "warning"; }
                else {
                    Cuenta c = new Cuenta();
                    c.setUsuario_id((Integer)session.getAttribute("usuarioId"));
                    c.setNombre(nombre);
                    c.setTipo(tipoCuenta);
                    c.setSaldo_inicial(saldo);
                    boolean ok = cdao.crearCuenta(c);
                    msg = ok ? "Cuenta creada" : "Error al crear cuenta"; tipo = ok ? "success" : "danger";
                    if (ok) { response.sendRedirect("cuentas.jsp"); return; }
                }
            } else if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String nombre = request.getParameter("nombre");
                String tipoCuenta = request.getParameter("tipo");
                double saldo = Double.parseDouble(request.getParameter("saldo_inicial"));
                if (nombre == null || nombre.trim().isEmpty()) { msg = "El nombre es obligatorio"; tipo = "warning"; }
                else if (saldo < 0) { msg = "El saldo inicial no puede ser negativo"; tipo = "warning"; }
                else if (cdao.existeNombreParaUsuario((Integer)session.getAttribute("usuarioId"), nombre.trim(), id)) { msg = "Ya existe una cuenta con ese nombre"; tipo = "warning"; }
                else {
                    Cuenta c = new Cuenta();
                    c.setId(id);
                    c.setUsuario_id((Integer)session.getAttribute("usuarioId"));
                    c.setNombre(nombre);
                    c.setTipo(tipoCuenta);
                    c.setSaldo_inicial(saldo);
                    boolean ok = cdao.actualizarCuenta(c);
                    msg = ok ? "Cuenta actualizada" : "Error al actualizar cuenta"; tipo = ok ? "success" : "danger";
                    if (ok) { response.sendRedirect("cuentas.jsp"); return; }
                }
            } else if ("delete".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean ok = cdao.eliminar(id);
                msg = ok ? "Cuenta eliminada" : "Error al eliminar cuenta"; tipo = ok ? "success" : "danger";
                if (ok) { response.sendRedirect("cuentas.jsp"); return; }
            }
        } catch (Exception ex) { msg = "Datos inválidos"; tipo = "warning"; }
    }
    List<Cuenta> cs = null; try { cs = new CuentaDAO().listarCuentas(); } catch (Exception e) { cs = java.util.Collections.emptyList(); }
%>
<html class="<%= theme %>" lang="es"><head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Cuentas</title>
        <link href="https://fonts.googleapis.com" rel="preconnect"/>
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect"/>
        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet"/>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <script id="tailwind-config"> tailwind.config = { darkMode: "class", theme: { extend: { colors: { "primary": "#137fec", "background-light": "#f6f7f8", "background-dark": "#101922" }, fontFamily: { "display": ["Manrope","sans-serif"] }, borderRadius: { "DEFAULT": "1rem", "lg": "1.5rem", "xl": "2rem", "full": "9999px" } } } } </script>
        <style> body { min-height: max(884px, 100dvh); } </style>
    </head>
    <body class="bg-background-light dark:bg-background-dark font-display">
        <div class="relative flex h-auto min-h-screen w-full flex-col overflow-x-hidden">
            <div class="flex items-center bg-background-light dark:bg-background-dark p-4 pb-2 justify-between sticky top-0 z-10">
                <div class="flex size-12 shrink-0 items-center justify-start"><a href="PControl_Finanzas.jsp" class="flex items-center justify-center rounded-full h-10 w-10 text-slate-800 dark:text-white"><span class="material-symbols-outlined text-2xl">arrow_back_ios_new</span></a></div>
                <h2 class="text-slate-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em] flex-1 text-center">Cuentas</h2>
                <div class="flex w-12 items-center justify-end"></div>
            </div>
            <div class="flex flex-col gap-4 p-4">
                <% if (msg != null) { %>
                <div class="rounded-lg px-4 py-2 text-sm <%= "success".equals(tipo) ? "bg-green-100 text-green-700" : ("danger".equals(tipo) ? "bg-red-100 text-red-700" : "bg-yellow-100 text-yellow-700") %>"><%= msg %></div>
                <% } %>
                <div class="flex flex-col gap-2 rounded-lg bg-white dark:bg-slate-800/50 p-4">
                    <h3 class="text-slate-900 dark:text-white text-lg font-bold">Crear cuenta</h3>
                    <form method="post" action="cuentas.jsp" class="flex flex-wrap gap-2 items-end">
                        <input name="nombre" placeholder="Nombre" class="form-input rounded bg-white dark:bg-zinc-800 border border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-3" />
                        <select name="tipo" class="form-select rounded bg-white dark:bg-zinc-800 border border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-2">
                            <option value="Ahorros">Ahorros</option>
                            <option value="Corriente">Corriente</option>
                            <option value="Tarjeta">Tarjeta</option>
                        </select>
                        <input name="saldo_inicial" type="number" step="0.01" placeholder="Saldo inicial" class="form-input rounded bg-white dark:bg-zinc-800 border border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-3" />
                        <input type="hidden" name="action" value="create" />
                        <button type="submit" class="rounded-full h-10 px-4 bg-primary text-white text-sm font-bold">Guardar</button>
                    </form>
                </div>
                <div class="flex flex-col gap-3">
                    <% for (Cuenta c : cs) { %>
                    <div class="flex items-center justify-between rounded-lg bg-white dark:bg-slate-800/50 p-4 shadow-sm">
                        <div class="flex items-center gap-4">
                            <div class="flex h-12 w-12 items-center justify-center rounded-full bg-slate-500/20 text-slate-500">
                                <span class="material-symbols-outlined">account_balance_wallet</span>
                            </div>
                            <form method="post" action="cuentas.jsp" class="flex items-center gap-2">
                                <input type="hidden" name="id" value="<%= c.getId() %>" />
                                <input name="nombre" value="<%= c.getNombre() %>" class="form-input rounded bg-white dark:bg-zinc-800 border border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-3" />
                                <select name="tipo" class="form-select rounded bg-white dark:bg-zinc-800 border border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-2">
                                    <option value="Ahorros" <%= "Ahorros".equalsIgnoreCase(c.getTipo())?"selected":"" %>>Ahorros</option>
                                    <option value="Corriente" <%= "Corriente".equalsIgnoreCase(c.getTipo())?"selected":"" %>>Corriente</option>
                                    <option value="Tarjeta" <%= "Tarjeta".equalsIgnoreCase(c.getTipo())?"selected":"" %>>Tarjeta</option>
                                </select>
                                <input name="saldo_inicial" type="number" step="0.01" value="<%= c.getSaldo_inicial() %>" class="form-input rounded bg-white dark:bg-zinc-800 border border-zinc-300 dark:border-zinc-700 text-zinc-900 dark:text-white h-10 px-3" />
                                <input type="hidden" name="action" value="update" />
                                <button type="submit" class="rounded-full h-10 px-4 bg-primary text-white text-sm font-bold">Guardar</button>
                            </form>
                        </div>
                        <form method="post" action="cuentas.jsp">
                            <input type="hidden" name="id" value="<%= c.getId() %>" />
                            <input type="hidden" name="action" value="delete" />
                            <button type="submit" class="rounded-full h-10 px-4 bg-red-500 text-white text-sm font-bold">Eliminar</button>
                        </form>
                    </div>
                    <% } %>
                    <% if (cs == null || cs.isEmpty()) { %>
                    <div class="rounded-lg bg-white dark:bg-slate-800/50 p-4 text-slate-600 dark:text-slate-300">No hay cuentas registradas.</div>
                    <% } %>
                </div>
            </div>
            <div class="fixed bottom-0 left-0 right-0 h-20 bg-white/80 dark:bg-background-dark/80 backdrop-blur-lg border-t border-slate-200 dark:border-slate-800">
                <div class="flex justify-around items-center h-full max-w-lg mx-auto">
                    <a href="PControl_Finanzas.jsp" class="flex flex-col items-center justify-center text-slate-400 dark:text-slate-500 w-16"><span class="material-symbols-outlined text-3xl">dashboard</span><span class="text-xs font-bold">Resumen</span></a>
                    <a href="movimientos.jsp" class="flex flex-col items-center justify-center text-slate-400 dark:text-slate-500 w-16"><span class="material-symbols-outlined text-3xl">receipt_long</span><span class="text-xs font-bold">Movimientos</span></a>
                    <a href="analisis.jsp" class="flex flex-col items-center justify-center text-slate-400 dark:text-slate-500 w-16"><span class="material-symbols-outlined text-3xl">pie_chart</span><span class="text-xs font-bold">Análisis</span></a>
                    <a href="cuentas.jsp" class="flex flex-col items-center justify-center text-primary w-16"><span class="material-symbols-outlined text-3xl">account_balance_wallet</span><span class="text-xs font-bold">Cuentas</span></a>
                </div>
            </div>
        </div>
    </body></html>
