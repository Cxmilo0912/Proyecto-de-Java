<!DOCTYPE html>
<html class="dark" lang="es">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Inicio de Sesion</title>

        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

        <link href="https://fonts.googleapis.com/css2?family=Manrope:wght@200;300;400;500;600;700;800&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>

        <script>
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        colors: {
                            primary: "#137fec",
                            "background-light": "#f6f7f8",
                            "background-dark": "#101922",
                        },
                        fontFamily: {
                            display: ["Manrope", "sans-serif"]
                        },
                        borderRadius: {
                            DEFAULT: "1rem",
                            lg: "2rem",
                            xl: "3rem",
                            full: "9999px"
                        },
                    },
                },
            }
        </script>

        <style>
            body {
                min-height: max(884px, 100dvh);
            }
            .material-symbols-outlined {
                font-size: 24px;
            }
        </style>
    </head>

    <body class="bg-background-light dark:bg-background-dark font-display">
        <div class="relative flex min-h-screen w-full flex-col items-center justify-center p-4">

            <div class="w-full max-w-sm text-center">
                <!-- Logo -->
                <div class="mb-8 flex h-20 w-20 mx-auto items-center justify-center rounded-xl bg-primary/20">
                    <span class="material-symbols-outlined text-primary text-5xl">
                        account_balance_wallet
                    </span>
                </div>

                <h1 class="text-3xl font-bold text-slate-900 dark:text-white">
                    FINTRIX
                </h1>
                <p class="mt-2 text-slate-600 dark:text-slate-400">
                    Inicia sesion para continuar
                </p>

                <!-- FORMULARIO -->
                <form action="Html/PControl_Finanzas.jsp" method="get" class="mt-8 space-y-4">

                    <!-- Email -->
                    <div class="text-left">
                        <label class="text-sm font-medium text-slate-800 dark:text-slate-200">
                            Correo Electronico
                        </label>
                        <div class="relative mt-1">
                            <span class="material-symbols-outlined absolute left-4 top-3 text-slate-500">
                                mail
                            </span>
                            <input
                                type="email"
                                required
                                placeholder="tu@email.com"
                                class="form-input w-full h-12 pl-12 pr-4 rounded-lg bg-white dark:bg-slate-800
                                border-slate-300 dark:border-slate-700
                                text-slate-900 dark:text-white
                                focus:ring-2 focus:ring-primary/20 focus:border-primary">
                        </div>
                    </div>

                    <!-- Password -->
                    <div class="text-left">
                        <label class="text-sm font-medium text-slate-800 dark:text-slate-200">
                            Contraseña
                        </label>
                        <div class="relative mt-1">
                            <span class="material-symbols-outlined absolute left-4 top-3 text-slate-500">
                                lock
                            </span>
                            <input
                                type="password"
                                required
                                placeholder="Ingresa tu contraseña"
                                class="form-input w-full h-12 pl-12 pr-4 rounded-lg bg-white dark:bg-slate-800
                                border-slate-300 dark:border-slate-700
                                text-slate-900 dark:text-white
                                focus:ring-2 focus:ring-primary/20 focus:border-primary">
                        </div>
                    </div>

                    <!-- Forgot -->
                    <div class="text-right">
                        <a href="#" class="text-sm text-primary font-medium hover:underline">
                            Olvidé mi contraseña
                        </a>
                    </div>

                    <!-- BotÃ³n -->
                    <button type="submit" class="flex h-12 w-full items-center justify-center rounded-lg bg-primary text-white text-base font-semibold leading-normal transition-colors hover:bg-primary/90">
                        Iniciar Sesion
                    </button>

                </form>

                <!-- Registro -->
                <p class="mt-8 text-sm text-slate-600 dark:text-slate-400">
                    ¿No tienes cuenta?
                    <a href="Html/registro_usuario.jsp" class="text-primary font-semibold hover:underline">
                        Regí­strate
                    </a>
                </p>
            </div>

        </div>
    </body>
</html>
