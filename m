Message-ID: <548631FB.9070304@...1856...>
Date: Tue, 09 Dec 2014 00:19:23 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1418078751-3614-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1418078751-3614-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] plugins, down-root: Code style clean-up
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

ACK

-Steffan

On 08-12-14 23:45, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
> 
> The coding style was somewhat chaotic.  Cleaning it up using the astyle
> tool.  The style parameters are coherent to what was agreed upon at the
> Munich Hackathon 2014 [1].
> 
>      astyle --style=allman --indent=spaces=4 -c
> 
> Also included a "Local variables" section which some editors may pick
> up automatically.
> 
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  src/plugins/down-root/down-root.c | 630 +++++++++++++++++++-------------------
>  1 file changed, 323 insertions(+), 307 deletions(-)
> 
> diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
> index f7a49a0..6931bec 100644
> --- a/src/plugins/down-root/down-root.c
> +++ b/src/plugins/down-root/down-root.c
> @@ -66,17 +66,17 @@ static void down_root_server (const int fd, char * const * argv, char * const *e
>   */
>  struct down_root_context
>  {
> -  /* Foreground's socket to background process */
> -  int foreground_fd;
> +    /* Foreground's socket to background process */
> +    int foreground_fd;
>  
> -  /* Process ID of background process */
> -  pid_t background_pid;
> +    /* Process ID of background process */
> +    pid_t background_pid;
>  
> -  /* Verbosity level of OpenVPN */
> -  int verb;
> +    /* Verbosity level of OpenVPN */
> +    int verb;
>  
> -  /* down command */
> -  char **command;
> +    /* down command */
> +    char **command;
>  };
>  
>  /*
> @@ -87,21 +87,21 @@ struct down_root_context
>  static const char *
>  get_env (const char *name, const char *envp[])
>  {
> -  if (envp)
> +    if (envp)
>      {
> -      int i;
> -      const int namelen = strlen (name);
> -      for (i = 0; envp[i]; ++i)
> -	{
> -	  if (!strncmp (envp[i], name, namelen))
> -	    {
> -	      const char *cp = envp[i] + namelen;
> -	      if (*cp == '=')
> -		return cp + 1;
> -	    }
> -	}
> +        int i;
> +        const int namelen = strlen (name);
> +        for (i = 0; envp[i]; ++i)
> +        {
> +            if (!strncmp (envp[i], name, namelen))
> +            {
> +                const char *cp = envp[i] + namelen;
> +                if (*cp == '=')
> +                    return cp + 1;
> +            }
> +        }
>      }
> -  return NULL;
> +    return NULL;
>  }
>  
>  /*
> @@ -110,13 +110,13 @@ get_env (const char *name, const char *envp[])
>  static int
>  string_array_len (const char *array[])
>  {
> -  int i = 0;
> -  if (array)
> +    int i = 0;
> +    if (array)
>      {
> -      while (array[i])
> -	++i;
> +        while (array[i])
> +            ++i;
>      }
> -  return i;
> +    return i;
>  }
>  
>  /*
> @@ -126,23 +126,23 @@ string_array_len (const char *array[])
>  static int
>  recv_control (int fd)
>  {
> -  unsigned char c;
> -  const ssize_t size = read (fd, &c, sizeof (c));
> -  if (size == sizeof (c))
> -    return c;
> -  else
> -    return -1;
> +    unsigned char c;
> +    const ssize_t size = read (fd, &c, sizeof (c));
> +    if (size == sizeof (c))
> +        return c;
> +    else
> +        return -1;
>  }
>  
>  static int
>  send_control (int fd, int code)
>  {
> -  unsigned char c = (unsigned char) code;
> -  const ssize_t size = write (fd, &c, sizeof (c));
> -  if (size == sizeof (c))
> -    return (int) size;
> -  else
> -    return -1;
> +    unsigned char c = (unsigned char) code;
> +    const ssize_t size = write (fd, &c, sizeof (c));
> +    if (size == sizeof (c))
> +        return (int) size;
> +    else
> +        return -1;
>  }
>  
>  /*
> @@ -153,22 +153,22 @@ send_control (int fd, int code)
>  static void
>  daemonize (const char *envp[])
>  {
> -  const char *daemon_string = get_env ("daemon", envp);
> -  if (daemon_string && daemon_string[0] == '1')
> +    const char *daemon_string = get_env ("daemon", envp);
> +    if (daemon_string && daemon_string[0] == '1')
>      {
> -      const char *log_redirect = get_env ("daemon_log_redirect", envp);
> -      int fd = -1;
> -      if (log_redirect && log_redirect[0] == '1')
> -	fd = dup (2);
> -      if (daemon (0, 0) < 0)
> -	{
> -	  warn ("DOWN-ROOT: daemonization failed");
> -	}
> -      else if (fd >= 3)
> -	{
> -	  dup2 (fd, 2);
> -	  close (fd);
> -	}
> +        const char *log_redirect = get_env ("daemon_log_redirect", envp);
> +        int fd = -1;
> +        if (log_redirect && log_redirect[0] == '1')
> +            fd = dup (2);
> +        if (daemon (0, 0) < 0)
> +        {
> +            warn ("DOWN-ROOT: daemonization failed");
> +        }
> +        else if (fd >= 3)
> +        {
> +            dup2 (fd, 2);
> +            close (fd);
> +        }
>      }
>  }
>  
> @@ -185,12 +185,12 @@ daemonize (const char *envp[])
>  static void
>  close_fds_except (int keep)
>  {
> -  int i;
> -  closelog ();
> -  for (i = 3; i <= 100; ++i)
> +    int i;
> +    closelog ();
> +    for (i = 3; i <= 100; ++i)
>      {
> -      if (i != keep)
> -	close (i);
> +        if (i != keep)
> +            close (i);
>      }
>  }
>  
> @@ -201,26 +201,26 @@ close_fds_except (int keep)
>  static void
>  set_signals (void)
>  {
> -  signal (SIGTERM, SIG_DFL);
> +    signal (SIGTERM, SIG_DFL);
>  
> -  signal (SIGINT, SIG_IGN);
> -  signal (SIGHUP, SIG_IGN);
> -  signal (SIGUSR1, SIG_IGN);
> -  signal (SIGUSR2, SIG_IGN);
> -  signal (SIGPIPE, SIG_IGN);
> +    signal (SIGINT, SIG_IGN);
> +    signal (SIGHUP, SIG_IGN);
> +    signal (SIGUSR1, SIG_IGN);
> +    signal (SIGUSR2, SIG_IGN);
> +    signal (SIGPIPE, SIG_IGN);
>  }
>  
>  
>  static void
>  free_context (struct down_root_context *context)
>  {
> -  if (context)
> +    if (context)
>      {
> -      if (context->command)
> -	{
> -	  free (context->command);
> -	}
> -      free (context);
> +        if (context->command)
> +        {
> +            free (context->command);
> +        }
> +        free (context);
>      }
>  }
>  
> @@ -229,226 +229,233 @@ free_context (struct down_root_context *context)
>   * calling execve()
>   */
>  static int
> -run_script(char * const *argv, char * const *envp) {
> -  pid_t pid;
> -  int ret = 0;
> -
> -  pid = fork();
> -  if (pid == (pid_t)0) { /* child side */
> -    execve(argv[0], argv, envp);
> -    /* If execve() fails to run, exit child with exit code 127 */
> -    err(127, "DOWN-ROOT: Failed execute: %s", argv[0]);
> -  } else if (pid < (pid_t)0 ){
> -    warn ("DOWN-ROOT: Failed to fork child to run %s", argv[0]);
> -    return -1;
> -  } else { /* parent side */
> -    if( waitpid (pid, &ret, 0) != pid ) {
> -      /* waitpid does not return error information via errno */
> -      fprintf(stderr, "DOWN-ROOT: waitpid() failed, don't know exit code of child (%s)\n", argv[0]);
> -      return -1;
> +run_script(char * const *argv, char * const *envp)
> +{
> +    pid_t pid;
> +    int ret = 0;
> +
> +    pid = fork();
> +    if (pid == (pid_t)0)   /* child side */
> +    {
> +        execve(argv[0], argv, envp);
> +        /* If execve() fails to run, exit child with exit code 127 */
> +        err(127, "DOWN-ROOT: Failed execute: %s", argv[0]);
> +    }
> +    else if (pid < (pid_t)0 )
> +    {
> +        warn ("DOWN-ROOT: Failed to fork child to run %s", argv[0]);
> +        return -1;
> +    }
> +    else     /* parent side */
> +    {
> +        if( waitpid (pid, &ret, 0) != pid )
> +        {
> +            /* waitpid does not return error information via errno */
> +            fprintf(stderr, "DOWN-ROOT: waitpid() failed, don't know exit code of child (%s)\n", argv[0]);
> +            return -1;
> +        }
>      }
> -  }
> -  return ret;
> +    return ret;
>  }
>  
>  OPENVPN_EXPORT openvpn_plugin_handle_t
>  openvpn_plugin_open_v1 (unsigned int *type_mask, const char *argv[], const char *envp[])
>  {
> -  struct down_root_context *context;
> -  int i = 0;
> -
> -  /*
> -   * Allocate our context
> -   */
> -  context = (struct down_root_context *) calloc (1, sizeof (struct down_root_context));
> -  if (!context)
> +    struct down_root_context *context;
> +    int i = 0;
> +
> +    /*
> +     * Allocate our context
> +     */
> +    context = (struct down_root_context *) calloc (1, sizeof (struct down_root_context));
> +    if (!context)
>      {
> -      warn ("DOWN-ROOT: Could not allocate memory for plug-in context");
> -      goto error;
> +        warn ("DOWN-ROOT: Could not allocate memory for plug-in context");
> +        goto error;
>      }
> -  context->foreground_fd = -1;
> -
> -  /*
> -   * Intercept the --up and --down callbacks
> -   */
> -  *type_mask = OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_UP) | OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_DOWN);
> -
> -  /*
> -   * Make sure we have two string arguments: the first is the .so name,
> -   * the second is the script command.
> -   */
> -  if (string_array_len (argv) < 2)
> +    context->foreground_fd = -1;
> +
> +    /*
> +     * Intercept the --up and --down callbacks
> +     */
> +    *type_mask = OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_UP) | OPENVPN_PLUGIN_MASK (OPENVPN_PLUGIN_DOWN);
> +
> +    /*
> +     * Make sure we have two string arguments: the first is the .so name,
> +     * the second is the script command.
> +     */
> +    if (string_array_len (argv) < 2)
>      {
> -      fprintf (stderr, "DOWN-ROOT: need down script command\n");
> -      goto error;
> +        fprintf (stderr, "DOWN-ROOT: need down script command\n");
> +        goto error;
>      }
>  
> -  /*
> -   * Save the arguments in our context
> -   */
> -  context->command = calloc(string_array_len(argv), sizeof(char *));
> -  if (!context->command)
> +    /*
> +     * Save the arguments in our context
> +     */
> +    context->command = calloc(string_array_len(argv), sizeof(char *));
> +    if (!context->command)
>      {
> -      warn ("DOWN-ROOT: Could not allocate memory for command array");
> -      goto error;
> +        warn ("DOWN-ROOT: Could not allocate memory for command array");
> +        goto error;
>      }
>  
> -  /* Ignore argv[0], as it contains just the plug-in file name */
> -  for (i = 1; i < string_array_len(argv); i++)
> +    /* Ignore argv[0], as it contains just the plug-in file name */
> +    for (i = 1; i < string_array_len(argv); i++)
>      {
> -      context->command[i-1] = (char *) argv[i];
> +        context->command[i-1] = (char *) argv[i];
>      }
>  
> -  /*
> -   * Get verbosity level from environment
> -   */
> -  {
> -    const char *verb_string = get_env ("verb", envp);
> -    if (verb_string)
> -      context->verb = atoi (verb_string);
> -  }
> +    /*
> +     * Get verbosity level from environment
> +     */
> +    {
> +        const char *verb_string = get_env ("verb", envp);
> +        if (verb_string)
> +            context->verb = atoi (verb_string);
> +    }
>  
> -  return (openvpn_plugin_handle_t) context;
> +    return (openvpn_plugin_handle_t) context;
>  
> - error:
> -  free_context (context);
> -  return NULL;
> +error:
> +    free_context (context);
> +    return NULL;
>  }
>  
>  OPENVPN_EXPORT int
>  openvpn_plugin_func_v1 (openvpn_plugin_handle_t handle, const int type, const char *argv[], const char *envp[])
>  {
> -  struct down_root_context *context = (struct down_root_context *) handle;
> +    struct down_root_context *context = (struct down_root_context *) handle;
>  
> -  if (type == OPENVPN_PLUGIN_UP && context->foreground_fd == -1) /* fork off a process to hold onto root */
> +    if (type == OPENVPN_PLUGIN_UP && context->foreground_fd == -1) /* fork off a process to hold onto root */
>      {
> -      pid_t pid;
> -      int fd[2];
> -
> -      /*
> -       * Make a socket for foreground and background processes
> -       * to communicate.
> -       */
> -      if (socketpair (PF_UNIX, SOCK_DGRAM, 0, fd) == -1)
> -	{
> -	  warn ("DOWN-ROOT: socketpair call failed");
> -	  return OPENVPN_PLUGIN_FUNC_ERROR;
> -	}
> -
> -      /*
> -       * Fork off the privileged process.  It will remain privileged
> -       * even after the foreground process drops its privileges.
> -       */
> -      pid = fork ();
> -
> -      if (pid)
> -	{
> -	  int status;
> -
> -	  /*
> -	   * Foreground Process
> -	   */
> -
> -	  context->background_pid = pid;
> -
> -	  /* close our copy of child's socket */
> -	  close (fd[1]);
> -
> -	  /* don't let future subprocesses inherit child socket */
> -	  if (fcntl (fd[0], F_SETFD, FD_CLOEXEC) < 0)
> -	    {
> -	      warn ("DOWN-ROOT: Set FD_CLOEXEC flag on socket file descriptor failed");
> -	    }
> -
> -	  /* wait for background child process to initialize */
> -	  status = recv_control (fd[0]);
> -	  if (status == RESPONSE_INIT_SUCCEEDED)
> -	    {
> -	      context->foreground_fd = fd[0];
> -	      return OPENVPN_PLUGIN_FUNC_SUCCESS;
> -	    }
> -	}
> -      else
> -	{
> -	  /*
> -	   * Background Process
> -	   */
> -
> -	  /* close all parent fds except our socket back to parent */
> -	  close_fds_except (fd[1]);
> -
> -	  /* Ignore most signals (the parent will receive them) */
> -	  set_signals ();
> -
> -	  /* Daemonize if --daemon option is set. */
> -	  daemonize (envp);
> -
> -	  /* execute the event loop */
> -	  down_root_server (fd[1], context->command, (char * const *) envp, context->verb);
> -
> -	  close (fd[1]);
> -	  exit (0);
> -	  return 0; /* NOTREACHED */
> -	}
> +        pid_t pid;
> +        int fd[2];
> +
> +        /*
> +         * Make a socket for foreground and background processes
> +         * to communicate.
> +         */
> +        if (socketpair (PF_UNIX, SOCK_DGRAM, 0, fd) == -1)
> +        {
> +            warn ("DOWN-ROOT: socketpair call failed");
> +            return OPENVPN_PLUGIN_FUNC_ERROR;
> +        }
> +
> +        /*
> +         * Fork off the privileged process.  It will remain privileged
> +         * even after the foreground process drops its privileges.
> +         */
> +        pid = fork ();
> +
> +        if (pid)
> +        {
> +            int status;
> +
> +            /*
> +             * Foreground Process
> +             */
> +
> +            context->background_pid = pid;
> +
> +            /* close our copy of child's socket */
> +            close (fd[1]);
> +
> +            /* don't let future subprocesses inherit child socket */
> +            if (fcntl (fd[0], F_SETFD, FD_CLOEXEC) < 0)
> +            {
> +                warn ("DOWN-ROOT: Set FD_CLOEXEC flag on socket file descriptor failed");
> +            }
> +
> +            /* wait for background child process to initialize */
> +            status = recv_control (fd[0]);
> +            if (status == RESPONSE_INIT_SUCCEEDED)
> +            {
> +                context->foreground_fd = fd[0];
> +                return OPENVPN_PLUGIN_FUNC_SUCCESS;
> +            }
> +        }
> +        else
> +        {
> +            /*
> +             * Background Process
> +             */
> +
> +            /* close all parent fds except our socket back to parent */
> +            close_fds_except (fd[1]);
> +
> +            /* Ignore most signals (the parent will receive them) */
> +            set_signals ();
> +
> +            /* Daemonize if --daemon option is set. */
> +            daemonize (envp);
> +
> +            /* execute the event loop */
> +            down_root_server (fd[1], context->command, (char * const *) envp, context->verb);
> +
> +            close (fd[1]);
> +            exit (0);
> +            return 0; /* NOTREACHED */
> +        }
>      }
> -  else if (type == OPENVPN_PLUGIN_DOWN && context->foreground_fd >= 0)
> +    else if (type == OPENVPN_PLUGIN_DOWN && context->foreground_fd >= 0)
>      {
> -      if (send_control (context->foreground_fd, COMMAND_RUN_SCRIPT) == -1)
> -	{
> -	  warn ("DOWN-ROOT: Error sending script execution signal to background process");
> -	}
> -      else
> -	{
> -	  const int status = recv_control (context->foreground_fd);
> -	  if (status == RESPONSE_SCRIPT_SUCCEEDED)
> -	    return OPENVPN_PLUGIN_FUNC_SUCCESS;
> -	  if (status == -1)
> -	    {
> -	      warn ("DOWN-ROOT: Error receiving script execution confirmation from background process");
> -	    }
> -	}
> +        if (send_control (context->foreground_fd, COMMAND_RUN_SCRIPT) == -1)
> +        {
> +            warn ("DOWN-ROOT: Error sending script execution signal to background process");
> +        }
> +        else
> +        {
> +            const int status = recv_control (context->foreground_fd);
> +            if (status == RESPONSE_SCRIPT_SUCCEEDED)
> +                return OPENVPN_PLUGIN_FUNC_SUCCESS;
> +            if (status == -1)
> +            {
> +                warn ("DOWN-ROOT: Error receiving script execution confirmation from background process");
> +            }
> +        }
>      }
> -  return OPENVPN_PLUGIN_FUNC_ERROR;
> +    return OPENVPN_PLUGIN_FUNC_ERROR;
>  }
>  
>  OPENVPN_EXPORT void
>  openvpn_plugin_close_v1 (openvpn_plugin_handle_t handle)
>  {
> -  struct down_root_context *context = (struct down_root_context *) handle;
> +    struct down_root_context *context = (struct down_root_context *) handle;
>  
> -  if (DEBUG (context->verb))
> -    fprintf (stderr, "DOWN-ROOT: close\n");
> +    if (DEBUG (context->verb))
> +        fprintf (stderr, "DOWN-ROOT: close\n");
>  
> -  if (context->foreground_fd >= 0)
> +    if (context->foreground_fd >= 0)
>      {
> -      /* tell background process to exit */
> -      if (send_control (context->foreground_fd, COMMAND_EXIT) == -1)
> -	{
> -	  warn ("DOWN-ROOT: Error signalling background process to exit");
> -	}
> -
> -      /* wait for background process to exit */
> -      if (context->background_pid > 0)
> -	waitpid (context->background_pid, NULL, 0);
> -
> -      close (context->foreground_fd);
> -      context->foreground_fd = -1;
> +        /* tell background process to exit */
> +        if (send_control (context->foreground_fd, COMMAND_EXIT) == -1)
> +        {
> +            warn ("DOWN-ROOT: Error signalling background process to exit");
> +        }
> +
> +        /* wait for background process to exit */
> +        if (context->background_pid > 0)
> +            waitpid (context->background_pid, NULL, 0);
> +
> +        close (context->foreground_fd);
> +        context->foreground_fd = -1;
>      }
>  
> -  free_context (context);
> +    free_context (context);
>  }
>  
>  OPENVPN_EXPORT void
>  openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
>  {
> -  struct down_root_context *context = (struct down_root_context *) handle;
> +    struct down_root_context *context = (struct down_root_context *) handle;
>  
> -  if (context && context->foreground_fd >= 0)
> +    if (context && context->foreground_fd >= 0)
>      {
> -      /* tell background process to exit */
> -      send_control (context->foreground_fd, COMMAND_EXIT);
> -      close (context->foreground_fd);
> -      context->foreground_fd = -1;
> +        /* tell background process to exit */
> +        send_control (context->foreground_fd, COMMAND_EXIT);
> +        close (context->foreground_fd);
> +        context->foreground_fd = -1;
>      }
>  }
>  
> @@ -458,74 +465,83 @@ openvpn_plugin_abort_v1 (openvpn_plugin_handle_t handle)
>  static void
>  down_root_server (const int fd, char * const *argv, char * const *envp, const int verb)
>  {
> -  /*
> -   * Do initialization
> -   */
> -  if (DEBUG (verb))
> -    fprintf (stderr, "DOWN-ROOT: BACKGROUND: INIT command='%s'\n", argv[0]);
> -
> -  /*
> -   * Tell foreground that we initialized successfully
> -   */
> -  if (send_control (fd, RESPONSE_INIT_SUCCEEDED) == -1)
> +    /*
> +     * Do initialization
> +     */
> +    if (DEBUG (verb))
> +        fprintf (stderr, "DOWN-ROOT: BACKGROUND: INIT command='%s'\n", argv[0]);
> +
> +    /*
> +     * Tell foreground that we initialized successfully
> +     */
> +    if (send_control (fd, RESPONSE_INIT_SUCCEEDED) == -1)
>      {
> -      warn ("DOWN-ROOT: BACKGROUND: write error on response socket [1]");
> -      goto done;
> +        warn ("DOWN-ROOT: BACKGROUND: write error on response socket [1]");
> +        goto done;
>      }
>  
> -  /*
> -   * Event loop
> -   */
> -  while (1)
> +    /*
> +     * Event loop
> +     */
> +    while (1)
>      {
> -      int command_code;
> -      int exit_code = -1;
> -
> -      /* get a command from foreground process */
> -      command_code = recv_control (fd);
> -
> -      if (DEBUG (verb))
> -	fprintf (stderr, "DOWN-ROOT: BACKGROUND: received command code: %d\n", command_code);
> -
> -      switch (command_code)
> -	{
> -	case COMMAND_RUN_SCRIPT:
> -	  if ( (exit_code = run_script(argv, envp)) == 0 ) /* Succeeded */
> -	    {
> -	      if (send_control (fd, RESPONSE_SCRIPT_SUCCEEDED) == -1)
> -		{
> -		  warn ("DOWN-ROOT: BACKGROUND: write error on response socket [2]");
> -		  goto done;
> -		}
> -	    }
> -	  else /* Failed */
> -	    {
> -	      fprintf(stderr, "DOWN-ROOT: BACKGROUND: %s exited with exit code %i\n", argv[0], exit_code);
> -	      if (send_control (fd, RESPONSE_SCRIPT_FAILED) == -1)
> -		{
> -		  warn ("DOWN-ROOT: BACKGROUND: write error on response socket [3]");
> -		  goto done;
> -		}
> -	    }
> -	  break;
> -
> -	case COMMAND_EXIT:
> -	  goto done;
> -
> -	case -1:
> -	  warn ("DOWN-ROOT: BACKGROUND: read error on command channel");
> -	  goto done;
> -
> -	default:
> -	  fprintf (stderr, "DOWN-ROOT: BACKGROUND: unknown command code: code=%d, exiting\n",
> -		   command_code);
> -	  goto done;
> -	}
> +        int command_code;
> +        int exit_code = -1;
> +
> +        /* get a command from foreground process */
> +        command_code = recv_control (fd);
> +
> +        if (DEBUG (verb))
> +            fprintf (stderr, "DOWN-ROOT: BACKGROUND: received command code: %d\n", command_code);
> +
> +        switch (command_code)
> +        {
> +        case COMMAND_RUN_SCRIPT:
> +            if ( (exit_code = run_script(argv, envp)) == 0 ) /* Succeeded */
> +            {
> +                if (send_control (fd, RESPONSE_SCRIPT_SUCCEEDED) == -1)
> +                {
> +                    warn ("DOWN-ROOT: BACKGROUND: write error on response socket [2]");
> +                    goto done;
> +                }
> +            }
> +            else /* Failed */
> +            {
> +                fprintf(stderr, "DOWN-ROOT: BACKGROUND: %s exited with exit code %i\n", argv[0], exit_code);
> +                if (send_control (fd, RESPONSE_SCRIPT_FAILED) == -1)
> +                {
> +                    warn ("DOWN-ROOT: BACKGROUND: write error on response socket [3]");
> +                    goto done;
> +                }
> +            }
> +            break;
> +
> +        case COMMAND_EXIT:
> +            goto done;
> +
> +        case -1:
> +            warn ("DOWN-ROOT: BACKGROUND: read error on command channel");
> +            goto done;
> +
> +        default:
> +            fprintf (stderr, "DOWN-ROOT: BACKGROUND: unknown command code: code=%d, exiting\n",
> +                     command_code);
> +            goto done;
> +        }
>      }
>  
> - done:
> -  if (DEBUG (verb))
> -    fprintf (stderr, "DOWN-ROOT: BACKGROUND: EXIT\n");
> +done:
> +    if (DEBUG (verb))
> +        fprintf (stderr, "DOWN-ROOT: BACKGROUND: EXIT\n");
>  
> -  return;
> +    return;
>  }
> +
> +
> +/*
> +Local variables:
> +c-file-style: "bsd"
> +c-basic-offset: 4
> +indent-tabs-mode: nil
> +End:
> +*/
> 

