Message-ID: <4F59BE3E.9000807@...515...>
Date: Fri, 09 Mar 2012 10:24:30 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-50-git-send-email-alon.barlev@...277...>
	<4F58B5D3.8030805@...515...>
	<CAOazyz2TVnmZ0EEisRJRV2hi2VT3L5=01dgVjHC9us_1toZBVQ@...278...>
In-Reply-To: <CAOazyz2TVnmZ0EEisRJRV2hi2VT3L5=01dgVjHC9us_1toZBVQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 49/52] build: move wrappers into
 platform module
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Thanks for the clarifications! I like the idea of moving some
functionality into more general-purpose libraries whenever possible.
Those libraries could then be - at least theoretically - used by other
projects, so that the code gets more exposure and testing, as well as
taking some of the maintenance load of our shoulders.

I give this one a feature-ACK, but could somebody else take a better
look at the actual code changes?

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc
=20
irc freenode net: mattock




> Well, at first I wanted to split it into its own libplatform distinct
> from libcompat.
>
> libcompat - emulation of missing library functions, drop-in replacement.
> libplatform - extensions to library functions, such as unicode or
> security additions.
>
> But then I've seen that there is too much openvpn specific logic,
> especially in log messages. So I left what I would have placed in
> libplatform in platform.c for now.
>
> After this round we should consider if we want to progress in this.
>
> One missing part is the exec wrappers which needs some work before
> moving to platform.
>
> Alon.
>
> 2012/3/8 Samuli Sepp=C3=A4nen <samuli@...515...>:
>> This probably makes sense, lots of good refactorings. That said, I'd
>> like to know how you selected what goes to platform.c?
>>
>> --
>> Samuli Sepp=C3=A4nen
>> Community Manager
>> OpenVPN Technologies, Inc
>>
>> irc freenode net: mattock
>>
>>
>>> + Some fixups within the platform.c functions.
>>> - need to check environment set on Windows.
>>>
>>> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
>>> ---
>>>  src/openvpn/Makefile.am    |    1 +
>>>  src/openvpn/buffer.c       |    2 +-
>>>  src/openvpn/crypto.c       |    6 +-
>>>  src/openvpn/error.c        |    2 +-
>>>  src/openvpn/init.c         |   18 +-
>>>  src/openvpn/manage.c       |   16 +-
>>>  src/openvpn/misc.c         |  295 ++----------------------------------
>>>  src/openvpn/misc.h         |  106 +-------------
>>>  src/openvpn/mstats.c       |    2 +-
>>>  src/openvpn/multi.c        |    2 +-
>>>  src/openvpn/openvpn.h      |    4 +-
>>>  src/openvpn/openvpn.vcproj |    8 +
>>>  src/openvpn/options.c      |   14 +-
>>>  src/openvpn/packet_id.c    |    2 +-
>>>  src/openvpn/pf.c           |    6 +-
>>>  src/openvpn/platform.c     |  369 ++++++++++++++++++++++++++++++++++++=
++++++++
>>>  src/openvpn/platform.h     |  142 +++++++++++++++++
>>>  src/openvpn/ps.c           |    2 +-
>>>  src/openvpn/ssl_openssl.c  |    2 +-
>>>  src/openvpn/ssl_verify.c   |    8 +-
>>>  src/openvpn/status.c       |    6 +-
>>>  src/openvpn/tun.c          |   12 +-
>>>  src/openvpn/win32.c        |   27 ----
>>>  23 files changed, 584 insertions(+), 468 deletions(-)
>>>  create mode 100644 src/openvpn/platform.c
>>>  create mode 100644 src/openvpn/platform.h
>>>
>>> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
>>> index 333eebc..6ba12b8 100644
>>> --- a/src/openvpn/Makefile.am
>>> +++ b/src/openvpn/Makefile.am
>>> @@ -58,6 +58,7 @@ openvpn_SOURCES =3D \
>>>         mbuf.c mbuf.h \
>>>         memdbg.h \
>>>         misc.c misc.h \
>>> +       platform.c platform.h \
>>>         console.c console.h \
>>>         mroute.c mroute.h \
>>>         mss.c mss.h \
>>> diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
>>> index ad30223..5eee3ee 100644
>>> --- a/src/openvpn/buffer.c
>>> +++ b/src/openvpn/buffer.c
>>> @@ -1080,7 +1080,7 @@ buffer_list_advance (struct buffer_list *ol, int =
n)
>>>  struct buffer_list *
>>>  buffer_list_file (const char *fn, int max_line_len)
>>>  {
>>> -  FILE *fp =3D openvpn_fopen (fn, "r");
>>> +  FILE *fp =3D platform_fopen (fn, "r");
>>>    struct buffer_list *bl =3D NULL;
>>>
>>>    if (fp)
>>> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
>>> index 2e2e5d7..f811966 100644
>>> --- a/src/openvpn/crypto.c
>>> +++ b/src/openvpn/crypto.c
>>> @@ -868,7 +868,7 @@ read_key_file (struct key2 *key2, const char *file,=
 const unsigned int flags)
>>>  #endif
>>>      {
>>>        in =3D alloc_buf_gc (2048, &gc);
>>> -      fd =3D openvpn_open (file, O_RDONLY, 0);
>>> +      fd =3D platform_open (file, O_RDONLY, 0);
>>>        if (fd =3D=3D -1)
>>>         msg (M_ERR, "Cannot open file key file '%s'", file);
>>>        size =3D read (fd, in.data, in.capacity);
>>> @@ -1029,7 +1029,7 @@ read_passphrase_hash (const char *passphrase_file,
>>>      const int min_passphrase_size =3D 8;
>>>      uint8_t buf[64];
>>>      int total_size =3D 0;
>>> -    int fd =3D openvpn_open (passphrase_file, O_RDONLY, 0);
>>> +    int fd =3D platform_open (passphrase_file, O_RDONLY, 0);
>>>
>>>      if (fd =3D=3D -1)
>>>        msg (M_ERR, "Cannot open passphrase file: '%s'", passphrase_file=
);
>>> @@ -1079,7 +1079,7 @@ write_key_file (const int nkeys, const char *file=
name)
>>>    const int bytes_per_line =3D 16;
>>>
>>>    /* open key file */
>>> -  fd =3D openvpn_open (filename, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR=
 | S_IWUSR);
>>> +  fd =3D platform_open (filename, O_CREAT | O_TRUNC | O_WRONLY, S_IRUS=
R | S_IWUSR);
>>>
>>>    if (fd =3D=3D -1)
>>>      msg (M_ERR, "Cannot open shared secret file '%s' for write", filen=
ame);
>>> diff --git a/src/openvpn/error.c b/src/openvpn/error.c
>>> index 1f2dd86..d6ad639 100644
>>> --- a/src/openvpn/error.c
>>> +++ b/src/openvpn/error.c
>>> @@ -640,7 +640,7 @@ x_check_status (int status,
>>>                  my_errno);
>>>
>>>           if (x_cs_err_delay_ms)
>>> -           sleep_milliseconds (x_cs_err_delay_ms);
>>> +           platform_sleep_milliseconds (x_cs_err_delay_ms);
>>>         }
>>>        gc_free (&gc);
>>>      }
>>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>>> index bba3cf8..bc7718e 100644
>>> --- a/src/openvpn/init.c
>>> +++ b/src/openvpn/init.c
>>> @@ -935,7 +935,7 @@ do_genkey (const struct options * options)
>>>                "shared secret output file (--secret)");
>>>
>>>        if (options->mlock)      /* should we disable paging? */
>>> -       do_mlockall (true);
>>> +       platform_mlockall (true);
>>>
>>>        nbits_written =3D write_key_file (2, options->shared_secret_file=
);
>>>
>>> @@ -1022,7 +1022,7 @@ do_uid_gid_chroot (struct context *c, bool no_del=
ay)
>>>        if (c->options.chroot_dir)
>>>         {
>>>           if (no_delay)
>>> -           do_chroot (c->options.chroot_dir);
>>> +           platform_chroot (c->options.chroot_dir);
>>>           else
>>>             msg (M_INFO, "NOTE: chroot %s", why_not);
>>>         }
>>> @@ -1030,8 +1030,8 @@ do_uid_gid_chroot (struct context *c, bool no_del=
ay)
>>>        /* set user and/or group that we want to setuid/setgid to */
>>>        if (no_delay)
>>>         {
>>> -         set_group (&c0->group_state);
>>> -         set_user (&c0->user_state);
>>> +         platform_group_set (&c0->platform_state_group);
>>> +         platform_user_set (&c0->platform_state_user);
>>>           c0->uid_gid_set =3D true;
>>>         }
>>>        else if (c0->uid_gid_specified)
>>> @@ -2780,8 +2780,8 @@ do_init_first_time (struct context *c)
>>>
>>>        /* get user and/or group that we want to setuid/setgid to */
>>>        c0->uid_gid_specified =3D
>>> -       get_group (c->options.groupname, &c0->group_state) |
>>> -       get_user (c->options.username, &c0->user_state);
>>> +       platform_group_get (c->options.groupname, &c0->platform_state_g=
roup) |
>>> +       platform_user_get (c->options.username, &c0->platform_state_use=
r);
>>>
>>>        /* get --writepid file descriptor */
>>>        get_pid_file (c->options.writepid, &c0->pid_state);
>>> @@ -2791,13 +2791,13 @@ do_init_first_time (struct context *c)
>>>
>>>        /* should we disable paging? */
>>>        if (c->options.mlock && c->did_we_daemonize)
>>> -       do_mlockall (true);     /* call again in case we daemonized */
>>> +       platform_mlockall (true);       /* call again in case we daemon=
ized */
>>>
>>>        /* save process ID in a file */
>>>        write_pid (&c0->pid_state);
>>>
>>>        /* should we change scheduling priority? */
>>> -      set_nice (c->options.nice);
>>> +      platform_nice (c->options.nice);
>>>      }
>>>  }
>>>
>>> @@ -3342,7 +3342,7 @@ init_instance (struct context *c, const struct en=
v_set *env, const unsigned int
>>>
>>>    /* should we disable paging? */
>>>    if (c->first_time && options->mlock)
>>> -    do_mlockall (true);
>>> +    platform_mlockall (true);
>>>
>>>  #if P2MP
>>>    /* get passwords if undefined */
>>> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
>>> index 85c9aca..1dddd41 100644
>>> --- a/src/openvpn/manage.c
>>> +++ b/src/openvpn/manage.c
>>> @@ -1146,7 +1146,7 @@ man_dispatch_command (struct management *man, str=
uct status_output *so, const ch
>>>      }
>>>    else if (streq (p[0], "pid"))
>>>      {
>>> -      msg (M_CLIENT, "SUCCESS: pid=3D%d", openvpn_getpid ());
>>> +      msg (M_CLIENT, "SUCCESS: pid=3D%d", platform_getpid ());
>>>      }
>>>  #ifdef MANAGEMENT_DEF_AUTH
>>>    else if (streq (p[0], "nclients"))
>>> @@ -1429,7 +1429,7 @@ man_record_peer_info (struct management *man)
>>>             {
>>>               const in_addr_t a =3D ntohl (addr.sin_addr.s_addr);
>>>               const int p =3D ntohs (addr.sin_port);
>>> -             FILE *fp =3D openvpn_fopen (man->settings.write_peer_info=
_file, "w");
>>> +             FILE *fp =3D platform_fopen (man->settings.write_peer_inf=
o_file, "w");
>>>               if (fp)
>>>                 {
>>>                   fprintf (fp, "%s\n%d\n", print_in_addr_t (a, 0, &gc),=
 p);
>>> @@ -2013,17 +2013,17 @@ man_settings_init (struct man_settings *ms,
>>>         */
>>>        if (client_user)
>>>         {
>>> -         struct user_state s;
>>> -         get_user (client_user, &s);
>>> -         ms->client_uid =3D user_state_uid (&s);
>>> +         struct platform_state_user s;
>>> +         platform_user_get (client_user, &s);
>>> +         ms->client_uid =3D platform_state_user_uid (&s);
>>>           msg (D_MANAGEMENT, "MANAGEMENT: client_uid=3D%d", ms->client_=
uid);
>>>           ASSERT (ms->client_uid >=3D 0);
>>>         }
>>>        if (client_group)
>>>         {
>>> -         struct group_state s;
>>> -         get_group (client_group, &s);
>>> -         ms->client_gid =3D group_state_gid (&s);
>>> +         struct platform_state_group s;
>>> +         platform_group_get (client_group, &s);
>>> +         ms->client_gid =3D platform_state_group_gid (&s);
>>>           msg (D_MANAGEMENT, "MANAGEMENT: client_gid=3D%d", ms->client_=
gid);
>>>           ASSERT (ms->client_gid >=3D 0);
>>>         }
>>> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
>>> index 2571194..2ded9bf 100644
>>> --- a/src/openvpn/misc.c
>>> +++ b/src/openvpn/misc.c
>>> @@ -56,122 +56,6 @@ int script_security =3D SSEC_BUILT_IN; /* GLOBAL */
>>>  /* contains SM_x value defined in misc.h */
>>>  int script_method =3D SM_EXECVE; /* GLOBAL */
>>>
>>> -/* Redefine the top level directory of the filesystem
>>> -   to restrict access to files for security */
>>> -void
>>> -do_chroot (const char *path)
>>> -{
>>> -  if (path)
>>> -    {
>>> -#ifdef HAVE_CHROOT
>>> -      const char *top =3D "/";
>>> -      if (chroot (path))
>>> -       msg (M_ERR, "chroot to '%s' failed", path);
>>> -      if (openvpn_chdir (top))
>>> -       msg (M_ERR, "cd to '%s' failed", top);
>>> -      msg (M_INFO, "chroot to '%s' and cd to '%s' succeeded", path, to=
p);
>>> -#else
>>> -      msg (M_FATAL, "Sorry but I can't chroot to '%s' because this ope=
rating system doesn't appear to support the chroot() system call", path);
>>> -#endif
>>> -    }
>>> -}
>>> -
>>> -/* Get/Set UID of process */
>>> -
>>> -bool
>>> -get_user (const char *username, struct user_state *state)
>>> -{
>>> -  bool ret =3D false;
>>> -  CLEAR (*state);
>>> -  if (username)
>>> -    {
>>> -#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>>> -      state->pw =3D getpwnam (username);
>>> -      if (!state->pw)
>>> -       msg (M_ERR, "failed to find UID for user %s", username);
>>> -      state->username =3D username;
>>> -      ret =3D true;
>>> -#else
>>> -      msg (M_FATAL, "cannot get UID for user %s -- platform lacks getp=
wname() or setuid() system calls", username);
>>> -#endif
>>> -    }
>>> -  return ret;
>>> -}
>>> -
>>> -void
>>> -set_user (const struct user_state *state)
>>> -{
>>> -#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>>> -  if (state->username && state->pw)
>>> -    {
>>> -      if (setuid (state->pw->pw_uid))
>>> -       msg (M_ERR, "setuid('%s') failed", state->username);
>>> -      msg (M_INFO, "UID set to %s", state->username);
>>> -    }
>>> -#endif
>>> -}
>>> -
>>> -/* Get/Set GID of process */
>>> -
>>> -bool
>>> -get_group (const char *groupname, struct group_state *state)
>>> -{
>>> -  bool ret =3D false;
>>> -  CLEAR (*state);
>>> -  if (groupname)
>>> -    {
>>> -#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>>> -      state->gr =3D getgrnam (groupname);
>>> -      if (!state->gr)
>>> -       msg (M_ERR, "failed to find GID for group %s", groupname);
>>> -      state->groupname =3D groupname;
>>> -      ret =3D true;
>>> -#else
>>> -      msg (M_FATAL, "cannot get GID for group %s -- platform lacks get=
grnam() or setgid() system calls", groupname);
>>> -#endif
>>> -    }
>>> -  return ret;
>>> -}
>>> -
>>> -void
>>> -set_group (const struct group_state *state)
>>> -{
>>> -#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>>> -  if (state->groupname && state->gr)
>>> -    {
>>> -      if (setgid (state->gr->gr_gid))
>>> -       msg (M_ERR, "setgid('%s') failed", state->groupname);
>>> -      msg (M_INFO, "GID set to %s", state->groupname);
>>> -#ifdef HAVE_SETGROUPS
>>> -      {
>>> -        gid_t gr_list[1];
>>> -       gr_list[0] =3D state->gr->gr_gid;
>>> -       if (setgroups (1, gr_list))
>>> -         msg (M_ERR, "setgroups('%s') failed", state->groupname);
>>> -      }
>>> -#endif
>>> -    }
>>> -#endif
>>> -}
>>> -
>>> -/* Change process priority */
>>> -void
>>> -set_nice (int niceval)
>>> -{
>>> -  if (niceval)
>>> -    {
>>> -#ifdef HAVE_NICE
>>> -      errno =3D 0;
>>> -      if (nice (niceval) < 0 && errno !=3D 0)
>>> -       msg (M_WARN | M_ERRNO, "WARNING: nice %d failed: %s", niceval, =
strerror(errno));
>>> -      else
>>> -       msg (M_INFO, "nice %d succeeded", niceval);
>>> -#else
>>> -      msg (M_WARN, "WARNING: nice %d failed (function not implemented)=
", niceval);
>>> -#endif
>>> -    }
>>> -}
>>> -
>>>  /*
>>>   * Pass tunnel endpoint and MTU parms to a user-supplied script.
>>>   * Used to execute the up/down script/plugins.
>>> @@ -253,7 +137,7 @@ get_pid_file (const char* filename, struct pid_stat=
e *state)
>>>    CLEAR (*state);
>>>    if (filename)
>>>      {
>>> -      state->fp =3D openvpn_fopen (filename, "w");
>>> +      state->fp =3D platform_fopen (filename, "w");
>>>        if (!state->fp)
>>>         msg (M_ERR, "Open error on pid file %s", filename);
>>>        state->filename =3D filename;
>>> @@ -266,42 +150,13 @@ write_pid (const struct pid_state *state)
>>>  {
>>>    if (state->filename && state->fp)
>>>      {
>>> -      unsigned int pid =3D openvpn_getpid ();
>>> +      unsigned int pid =3D platform_getpid ();
>>>        fprintf(state->fp, "%u\n", pid);
>>>        if (fclose (state->fp))
>>>         msg (M_ERR, "Close error on pid file %s", state->filename);
>>>      }
>>>  }
>>>
>>> -/* Get current PID */
>>> -unsigned int
>>> -openvpn_getpid ()
>>> -{
>>> -#ifdef WIN32
>>> -  return (unsigned int) GetCurrentProcessId ();
>>> -#else
>>> -#ifdef HAVE_GETPID
>>> -  return (unsigned int) getpid ();
>>> -#else
>>> -  return 0;
>>> -#endif
>>> -#endif
>>> -}
>>> -
>>> -/* Disable paging */
>>> -void
>>> -do_mlockall(bool print_msg)
>>> -{
>>> -#ifdef HAVE_MLOCKALL
>>> -  if (mlockall (MCL_CURRENT | MCL_FUTURE))
>>> -    msg (M_WARN | M_ERRNO, "WARNING: mlockall call failed");
>>> -  else if (print_msg)
>>> -    msg (M_INFO, "mlockall call succeeded");
>>> -#else
>>> -  msg (M_WARN, "WARNING: mlockall call failed (function not implemente=
d)");
>>> -#endif
>>> -}
>>> -
>>>  /*
>>>   * Set standard file descriptors to /dev/null
>>>   */
>>> @@ -325,27 +180,6 @@ set_std_files_to_null (bool stdin_only)
>>>  }
>>>
>>>  /*
>>> - * Wrapper for chdir library function
>>> - */
>>> -int
>>> -openvpn_chdir (const char* dir)
>>> -{
>>> -#ifdef HAVE_CHDIR
>>> -#ifdef WIN32
>>> -  int res;
>>> -  struct gc_arena gc =3D gc_new ();
>>> -  res =3D _wchdir (wide_string (dir, &gc));
>>> -  gc_free (&gc);
>>> -  return res;
>>> -#else
>>> -  return chdir (dir);
>>> -#endif
>>> -#else
>>> -  return -1;
>>> -#endif
>>> -}
>>> -
>>> -/*
>>>   *  dup inetd/xinetd socket descriptor and save
>>>   */
>>>
>>> @@ -391,32 +225,6 @@ warn_if_group_others_accessible (const char* filen=
ame)
>>>  }
>>>
>>>  /*
>>> - * convert system() return into a success/failure value
>>> - */
>>> -bool
>>> -system_ok (int stat)
>>> -{
>>> -#ifdef WIN32
>>> -  return stat =3D=3D 0;
>>> -#else
>>> -  return stat !=3D -1 && WIFEXITED (stat) && WEXITSTATUS (stat) =3D=3D=
 0;
>>> -#endif
>>> -}
>>> -
>>> -/*
>>> - * did system() call execute the given command?
>>> - */
>>> -bool
>>> -system_executed (int stat)
>>> -{
>>> -#ifdef WIN32
>>> -  return stat !=3D -1;
>>> -#else
>>> -  return stat !=3D -1 && WEXITSTATUS (stat) !=3D 127;
>>> -#endif
>>> -}
>>> -
>>> -/*
>>>   * Print an error message based on the status code returned by system(=
).
>>>   */
>>>  const char *
>>> @@ -456,7 +264,7 @@ openvpn_execve_check (const struct argv *a, const s=
truct env_set *es, const unsi
>>>    const int stat =3D openvpn_execve (a, es, flags);
>>>    int ret =3D false;
>>>
>>> -  if (system_ok (stat))
>>> +  if (platform_system_ok (stat))
>>>      ret =3D true;
>>>    else
>>>      {
>>> @@ -554,7 +362,6 @@ openvpn_system (const char *command, const struct e=
nv_set *es, unsigned int flag
>>>  {
>>>  #ifdef HAVE_SYSTEM
>>>    int ret;
>>> -  struct gc_arena gc;
>>>
>>>    perf_push (PERF_SCRIPT);
>>>
>>> @@ -573,13 +380,7 @@ openvpn_system (const char *command, const struct =
env_set *es, unsigned int flag
>>>    /*
>>>     * execute the command
>>>     */
>>> -#ifdef WIN32
>>> -  gc =3D gc_new ();
>>> -  ret =3D _wsystem (wide_string (command, &gc));
>>> -  gc_free (&gc);
>>> -#else
>>> -  ret =3D system (command);
>>> -#endif
>>> +  ret =3D platform_system(command);
>>>
>>>    /* debugging */
>>>    dmsg (D_SCRIPT, "SYSTEM return=3D%u", ret);
>>> @@ -599,19 +400,6 @@ openvpn_system (const char *command, const struct =
env_set *es, unsigned int flag
>>>  #endif
>>>  }
>>>
>>> -int
>>> -openvpn_access (const char *path, int mode)
>>> -{
>>> -#ifdef WIN32
>>> -  struct gc_arena gc =3D gc_new ();
>>> -  int ret =3D _waccess (wide_string (path, &gc), mode);
>>> -  gc_free (&gc);
>>> -  return ret;
>>> -#else
>>> -  return access (path, mode);
>>> -#endif
>>> -}
>>> -
>>>  /*
>>>   * Run execve() inside a fork(), duping stdout.  Designed to replicate=
 the semantics of popen() but
>>>   * in a safer way that doesn't require the invocation of a shell or th=
e risks
>>> @@ -981,7 +769,7 @@ env_set_remove_from_environment (const struct env_s=
et *es)
>>>
>>>  static struct env_item *global_env =3D NULL; /* GLOBAL */
>>>
>>> -static void
>>> +void
>>>  manage_env (char *str)
>>>  {
>>>    remove_env_item (str, true, &global_env);
>>> @@ -1078,27 +866,11 @@ setenv_str_ex (struct env_set *es,
>>>      }
>>>    else
>>>      {
>>> -#if defined(WIN32)
>>> +      char *str =3D construct_name_value (name_tmp, val_tmp, NULL);
>>> +      if (platform_putenv(str))
>>>        {
>>> -        if (!SetEnvironmentVariableW (wide_string (name_tmp, &gc),
>>> -                                      wide_string (val_tmp, &gc)))
>>> -         msg (M_WARN | M_ERRNO, "SetEnvironmentVariable failed, name=
=3D'%s', value=3D'%s'",
>>> -              name_tmp,
>>> -              val_tmp ? val_tmp : "NULL");
>>> +        msg (M_WARN | M_ERRNO, "putenv('%s') failed", str);
>>>        }
>>> -#elif defined(HAVE_PUTENV)
>>> -      {
>>> -       char *str =3D construct_name_value (name_tmp, val_tmp, NULL);
>>> -       int status;
>>> -
>>> -       status =3D putenv (str);
>>> -       /*msg (M_INFO, "PUTENV '%s'", str);*/
>>> -       if (!status)
>>> -         manage_env (str);
>>> -       if (status)
>>> -         msg (M_WARN | M_ERRNO, "putenv('%s') failed", str);
>>> -      }
>>> -#endif
>>>      }
>>>
>>>    gc_free (&gc);
>>> @@ -1162,35 +934,6 @@ count_netmask_bits(const char *dotted_quad)
>>>    return ((int)result);
>>>  }
>>>
>>> -/*
>>> - * Go to sleep for n milliseconds.
>>> - */
>>> -void
>>> -sleep_milliseconds (unsigned int n)
>>> -{
>>> -#ifdef WIN32
>>> -  Sleep (n);
>>> -#else
>>> -  struct timeval tv;
>>> -  tv.tv_sec =3D n / 1000;
>>> -  tv.tv_usec =3D (n % 1000) * 1000;
>>> -  select (0, NULL, NULL, NULL, &tv);
>>> -#endif
>>> -}
>>> -
>>> -/*
>>> - * Go to sleep indefinitely.
>>> - */
>>> -void
>>> -sleep_until_signal (void)
>>> -{
>>> -#ifdef WIN32
>>> -  ASSERT (0);
>>> -#else
>>> -  select (0, NULL, NULL, NULL, NULL);
>>> -#endif
>>> -}
>>> -
>>>  /* return true if filename can be opened for read */
>>>  bool
>>>  test_file (const char *filename)
>>> @@ -1198,7 +941,7 @@ test_file (const char *filename)
>>>    bool ret =3D false;
>>>    if (filename)
>>>      {
>>> -      FILE *fp =3D openvpn_fopen (filename, "r");
>>> +      FILE *fp =3D platform_fopen (filename, "r");
>>>        if (fp)
>>>         {
>>>           fclose (fp);
>>> @@ -1246,7 +989,7 @@ create_temp_file (const char *directory, const cha=
r *prefix, struct gc_arena *gc
>>>
>>>        /* Atomically create the file.  Errors out if the file already
>>>           exists.  */
>>> -      fd =3D openvpn_open (retfname, O_CREAT | O_EXCL | O_WRONLY, S_IR=
USR | S_IWUSR);
>>> +      fd =3D platform_open (retfname, O_CREAT | O_EXCL | O_WRONLY, S_I=
RUSR | S_IWUSR);
>>>        if (fd !=3D -1)
>>>          {
>>>            close (fd);
>>> @@ -1342,22 +1085,6 @@ gen_path (const char *directory, const char *fil=
ename, struct gc_arena *gc)
>>>      return NULL;
>>>  }
>>>
>>> -/* delete a file, return true if succeeded */
>>> -bool
>>> -delete_file (const char *filename)
>>> -{
>>> -#if defined(WIN32)
>>> -  struct gc_arena gc =3D gc_new ();
>>> -  BOOL ret =3D DeleteFileW (wide_string (filename, &gc));
>>> -  gc_free (&gc);
>>> -  return (ret !=3D 0);
>>> -#elif defined(HAVE_UNLINK)
>>> -  return (unlink (filename) =3D=3D 0);
>>> -#else
>>> -  return false;
>>> -#endif
>>> -}
>>> -
>>>  bool
>>>  absolute_pathname (const char *pathname)
>>>  {
>>> @@ -1524,7 +1251,7 @@ get_user_pass_cr (struct user_pass *up,
>>>
>>>           warn_if_group_others_accessible (auth_file);
>>>
>>> -         fp =3D openvpn_fopen (auth_file, "r");
>>> +         fp =3D platform_fopen (auth_file, "r");
>>>           if (!fp)
>>>             msg (M_ERR, "Error opening '%s' auth file: %s", prefix, aut=
h_file);
>>>
>>> diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
>>> index 12a8f71..d4c8e33 100644
>>> --- a/src/openvpn/misc.h
>>> +++ b/src/openvpn/misc.h
>>> @@ -29,6 +29,7 @@
>>>  #include "common.h"
>>>  #include "integer.h"
>>>  #include "buffer.h"
>>> +#include "platform.h"
>>>
>>>  /* socket descriptor passed by inetd/xinetd server to us */
>>>  #define INETD_SOCKET_DESCRIPTOR 0
>>> @@ -58,37 +59,6 @@ struct env_set {
>>>    struct env_item *list;
>>>  };
>>>
>>> -/* Get/Set UID of process */
>>> -
>>> -struct user_state {
>>> -#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>>> -  const char *username;
>>> -  struct passwd *pw;
>>> -#else
>>> -  int dummy;
>>> -#endif
>>> -};
>>> -
>>> -bool get_user (const char *username, struct user_state *state);
>>> -void set_user (const struct user_state *state);
>>> -
>>> -/* Get/Set GID of process */
>>> -
>>> -struct group_state {
>>> -#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>>> -  const char *groupname;
>>> -  struct group *gr;
>>> -#else
>>> -  int dummy;
>>> -#endif
>>> -};
>>> -
>>> -bool get_group (const char *groupname, struct group_state *state);
>>> -void set_group (const struct group_state *state);
>>> -
>>> -void set_nice (int niceval);
>>> -void do_chroot (const char *path);
>>> -
>>>  void run_up_down (const char *command,
>>>                   const struct plugin_list *plugins,
>>>                   int plugin_type,
>>> @@ -111,9 +81,6 @@ struct pid_state {
>>>
>>>  void get_pid_file (const char* filename, struct pid_state *state);
>>>  void write_pid (const struct pid_state *state);
>>> -unsigned int openvpn_getpid (void);
>>> -
>>> -void do_mlockall (bool print_msg); /* Disable paging */
>>>
>>>  /* check file protections */
>>>  void warn_if_group_others_accessible(const char* filename);
>>> @@ -122,9 +89,6 @@ void warn_if_group_others_accessible(const char* fil=
ename);
>>>  #define S_SCRIPT (1<<0)
>>>  #define S_FATAL  (1<<1)
>>>
>>> -/* interpret the status code returned by system()/execve() */
>>> -bool system_ok(int);
>>> -bool system_executed (int stat);
>>>  const char *system_error_message (int, struct gc_arena *gc);
>>>
>>>  /* wrapper around the execve() call */
>>> @@ -133,7 +97,6 @@ int openvpn_execve (const struct argv *a, const stru=
ct env_set *es, const unsign
>>>  bool openvpn_execve_check (const struct argv *a, const struct env_set =
*es, const unsigned int flags, const char *error_message);
>>>  bool openvpn_execve_allowed (const unsigned int flags);
>>>  int openvpn_system (const char *command, const struct env_set *es, uns=
igned int flags);
>>> -int openvpn_access (const char *path, int mode);
>>>
>>>  static inline bool
>>>  openvpn_run_script (const struct argv *a, const struct env_set *es, co=
nst unsigned int flags, const char *hook)
>>> @@ -144,37 +107,6 @@ openvpn_run_script (const struct argv *a, const st=
ruct env_set *es, const unsign
>>>    return openvpn_execve_check(a, es, flags | S_SCRIPT, msg);
>>>  }
>>>
>>> -#ifdef WIN32
>>> -FILE * openvpn_fopen (const char *path, const char *mode);
>>> -#else
>>> -static inline FILE *
>>> -openvpn_fopen (const char *path, const char *mode)
>>> -{
>>> -  return fopen (path, mode);
>>> -}
>>> -#endif
>>> -
>>> -#ifdef WIN32
>>> -int openvpn_open (const char *path, int flags, int mode);
>>> -#else
>>> -static inline int
>>> -openvpn_open (const char *path, int flags, mode_t mode)
>>> -{
>>> -  return open (path, flags, mode);
>>> -}
>>> -#endif
>>> -
>>> -#ifdef WIN32
>>> -typedef struct _stat openvpn_stat_t;
>>> -int openvpn_stat (const char *path, openvpn_stat_t *buf);
>>> -#else
>>> -typedef struct stat openvpn_stat_t;
>>> -static inline int
>>> -openvpn_stat (const char *path, openvpn_stat_t *buf)
>>> -{
>>> -  return stat (path, buf);
>>> -}
>>> -#endif
>>>
>>>  #ifdef HAVE_STRERROR
>>>  /* a thread-safe version of strerror */
>>> @@ -184,9 +116,6 @@ const char* strerror_ts (int errnum, struct gc_aren=
a *gc);
>>>  /* Set standard file descriptors to /dev/null */
>>>  void set_std_files_to_null (bool stdin_only);
>>>
>>> -/* Wrapper for chdir library function */
>>> -int openvpn_chdir (const char* dir);
>>> -
>>>  /* dup inetd/xinetd socket descriptor and save */
>>>  extern int inetd_socket_descriptor;
>>>  void save_inetd_socket_descriptor (void);
>>> @@ -242,12 +171,6 @@ const char **make_extended_arg_array (char **p, st=
ruct gc_arena *gc);
>>>  int count_netmask_bits(const char *);
>>>  unsigned int count_bits(unsigned int );
>>>
>>> -/* go to sleep for n milliseconds */
>>> -void sleep_milliseconds (unsigned int n);
>>> -
>>> -/* go to sleep indefinitely */
>>> -void sleep_until_signal (void);
>>> -
>>>  /* an analogue to the random() function, but use OpenSSL functions if =
available */
>>>  #ifdef ENABLE_CRYPTO
>>>  long int get_random(void);
>>> @@ -264,9 +187,6 @@ const char *create_temp_file (const char *directory=
, const char *prefix, struct
>>>  /* put a directory and filename together */
>>>  const char *gen_path (const char *directory, const char *filename, str=
uct gc_arena *gc);
>>>
>>> -/* delete a file, return true if succeeded */
>>> -bool delete_file (const char *filename);
>>> -
>>>  /* return true if pathname is absolute */
>>>  bool absolute_pathname (const char *pathname);
>>>
>>> @@ -448,28 +368,4 @@ void argv_printf_cat (struct argv *a, const char *=
format, ...)
>>>  #endif
>>>    ;
>>>
>>> -/*
>>> - * Extract UID or GID
>>> - */
>>> -
>>> -static inline int
>>> -user_state_uid (const struct user_state *s)
>>> -{
>>> -#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>>> -  if (s->pw)
>>> -    return s->pw->pw_uid;
>>> -#endif
>>> -  return -1;
>>> -}
>>> -
>>> -static inline int
>>> -group_state_gid (const struct group_state *s)
>>> -{
>>> -#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>>> -  if (s->gr)
>>> -    return s->gr->gr_gid;
>>> -#endif
>>> -  return -1;
>>> -}
>>> -
>>>  #endif
>>> diff --git a/src/openvpn/mstats.c b/src/openvpn/mstats.c
>>> index b4b864b..3be493c 100644
>>> --- a/src/openvpn/mstats.c
>>> +++ b/src/openvpn/mstats.c
>>> @@ -114,7 +114,7 @@ mstats_close(void)
>>>        mmap_stats->state =3D MSTATS_EXPIRED;
>>>        if (munmap((void *)mmap_stats, sizeof(struct mmap_stats)))
>>>         msg (M_WARN | M_ERRNO, "mstats_close: munmap error");
>>> -      delete_file(mmap_fn);
>>> +      platform_unlink(mmap_fn);
>>>        mmap_stats =3D NULL;
>>>      }
>>>  }
>>> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
>>> index e79c6f1..9876b80 100644
>>> --- a/src/openvpn/multi.c
>>> +++ b/src/openvpn/multi.c
>>> @@ -1452,7 +1452,7 @@ multi_client_connect_post (struct multi_context *=
m,
>>>                              option_types_found,
>>>                              mi->context.c2.es);
>>>
>>> -      if (!delete_file (dc_file))
>>> +      if (!platform_unlink (dc_file))
>>>         msg (D_MULTI_ERRORS, "MULTI: problem deleting temporary file: %=
s",
>>>              dc_file);
>>>
>>> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
>>> index b314885..0732d0f 100644
>>> --- a/src/openvpn/openvpn.h
>>> +++ b/src/openvpn/openvpn.h
>>> @@ -143,8 +143,8 @@ struct context_0
>>>    /* workspace for --user/--group */
>>>    bool uid_gid_specified;
>>>    bool uid_gid_set;
>>> -  struct user_state user_state;
>>> -  struct group_state group_state;
>>> +  struct platform_state_user platform_state_user;
>>> +  struct platform_state_group platform_state_group;
>>>  };
>>>
>>>
>>> diff --git a/src/openvpn/openvpn.vcproj b/src/openvpn/openvpn.vcproj
>>> index 6c19621..4680e52 100644
>>> --- a/src/openvpn/openvpn.vcproj
>>> +++ b/src/openvpn/openvpn.vcproj
>>> @@ -347,6 +347,10 @@
>>>                                 >
>>>                         </File>
>>>                         <File
>>> +                               RelativePath=3D".\platform.c"
>>> +                               >
>>> +                       </File>
>>> +                       <File
>>>                                 RelativePath=3D".\plugin.c"
>>>                                 >
>>>                         </File>
>>> @@ -649,6 +653,10 @@
>>>                                 >
>>>                         </File>
>>>                         <File
>>> +                               RelativePath=3D".\platform.h"
>>> +                               >
>>> +                       </File>
>>> +                       <File
>>>                                 RelativePath=3D".\plugin.h"
>>>                                 >
>>>                         </File>
>>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>>> index 258b060..bd83843 100644
>>> --- a/src/openvpn/options.c
>>> +++ b/src/openvpn/options.c
>>> @@ -920,7 +920,7 @@ setenv_settings (struct env_set *es, const struct o=
ptions *o)
>>>    setenv_int (es, "daemon", o->daemon);
>>>    setenv_int (es, "daemon_log_redirect", o->log);
>>>    setenv_unsigned (es, "daemon_start_time", time(NULL));
>>> -  setenv_int (es, "daemon_pid", openvpn_getpid());
>>> +  setenv_int (es, "daemon_pid", platform_getpid());
>>>
>>>  #ifdef ENABLE_CONNECTION
>>>    if (o->connection_list)
>>> @@ -2640,18 +2640,18 @@ check_file_access(const int type, const char *f=
ile, const int mode, const char *
>>>        char *fullpath =3D strdup(file);  /* POSIX dirname() implementai=
on may modify its arguments */
>>>        char *dirpath =3D dirname(fullpath);
>>>
>>> -      if (openvpn_access (dirpath, mode|X_OK) !=3D 0)
>>> +      if (platform_access (dirpath, mode|X_OK) !=3D 0)
>>>            errcode =3D errno;
>>>        free(fullpath);
>>>      }
>>>
>>>    /* Is the file itself accessible? */
>>> -  if (!errcode && (type & CHKACC_FILE) && (openvpn_access (file, mode)=
 !=3D 0) )
>>> +  if (!errcode && (type & CHKACC_FILE) && (platform_access (file, mode=
) !=3D 0) )
>>>        errcode =3D errno;
>>>
>>>    /* If the file exists and is accessible, is it writable? */
>>> -  if (!errcode && (type & CHKACC_FILEXSTWR) && (openvpn_access (file, =
F_OK) =3D=3D 0) )
>>> -    if (openvpn_access (file, W_OK) !=3D 0)
>>> +  if (!errcode && (type & CHKACC_FILEXSTWR) && (platform_access (file,=
 F_OK) =3D=3D 0) )
>>> +    if (platform_access (file, W_OK) !=3D 0)
>>>        errcode =3D errno;
>>>
>>>    /* Scream if an error is found */
>>> @@ -3755,7 +3755,7 @@ read_config_file (struct options *options,
>>>        if (streq (file, "stdin"))
>>>         fp =3D stdin;
>>>        else
>>> -       fp =3D openvpn_fopen (file, "r");
>>> +       fp =3D platform_fopen (file, "r");
>>>        if (fp)
>>>         {
>>>           line_num =3D 0;
>>> @@ -4528,7 +4528,7 @@ add_option (struct options *options,
>>>    else if (streq (p[0], "cd") && p[1])
>>>      {
>>>        VERIFY_PERMISSION (OPT_P_GENERAL);
>>> -      if (openvpn_chdir (p[1]))
>>> +      if (platform_chdir (p[1]))
>>>         {
>>>           msg (M_ERR, "cd to '%s' failed", p[1]);
>>>           goto err;
>>> diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
>>> index 186f074..0102129 100644
>>> --- a/src/openvpn/packet_id.c
>>> +++ b/src/openvpn/packet_id.c
>>> @@ -368,7 +368,7 @@ packet_id_persist_load (struct packet_id_persist *p=
, const char *filename)
>>>    if (!packet_id_persist_enabled (p))
>>>      {
>>>        /* open packet-id persist file for both read and write */
>>> -      p->fd =3D openvpn_open (filename,
>>> +      p->fd =3D platform_open (filename,
>>>                              O_CREAT | O_RDWR | O_BINARY,
>>>                              S_IRUSR | S_IWUSR);
>>>        if (p->fd =3D=3D -1)
>>> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
>>> index 729792e..7ed1e70 100644
>>> --- a/src/openvpn/pf.c
>>> +++ b/src/openvpn/pf.c
>>> @@ -504,8 +504,8 @@ pf_check_reload (struct context *c)
>>>        && c->c2.pf.filename
>>>        && event_timeout_trigger (&c->c2.pf.reload, &c->c2.timeval, ETT_=
DEFAULT))
>>>      {
>>> -      openvpn_stat_t s;
>>> -      if (!openvpn_stat (c->c2.pf.filename, &s))
>>> +      platform_stat_t s;
>>> +      if (!platform_stat (c->c2.pf.filename, &s))
>>>         {
>>>           if (s.st_mtime > c->c2.pf.file_last_mod)
>>>             {
>>> @@ -605,7 +605,7 @@ pf_destroy_context (struct pf_context *pfc)
>>>  #ifdef PLUGIN_PF
>>>    if (pfc->filename)
>>>      {
>>> -      delete_file (pfc->filename);
>>> +      platform_unlink (pfc->filename);
>>>        free (pfc->filename);
>>>      }
>>>  #endif
>>> diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
>>> new file mode 100644
>>> index 0000000..c79f680
>>> --- /dev/null
>>> +++ b/src/openvpn/platform.c
>>> @@ -0,0 +1,369 @@
>>> +/*
>>> + *  OpenVPN -- An application to securely tunnel IP networks
>>> + *             over a single TCP/UDP port, with support for SSL/TLS-ba=
sed
>>> + *             session authentication and key exchange,
>>> + *             packet encryption, packet authentication, and
>>> + *             packet compression.
>>> + *
>>> + *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...1699...=
.>
>>> + *
>>> + *  This program is free software; you can redistribute it and/or modi=
fy
>>> + *  it under the terms of the GNU General Public License version 2
>>> + *  as published by the Free Software Foundation.
>>> + *
>>> + *  This program is distributed in the hope that it will be useful,
>>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + *  GNU General Public License for more details.
>>> + *
>>> + *  You should have received a copy of the GNU General Public License
>>> + *  along with this program (see the file COPYING included with this
>>> + *  distribution); if not, write to the Free Software Foundation, Inc.,
>>> + *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>>> + */
>>> +
>>> +#ifdef HAVE_CONFIG_H
>>> +#include "config.h"
>>> +#elif defined(_MSC_VER)
>>> +#include "config-msvc.h"
>>> +#endif
>>> +
>>> +#include "syshead.h"
>>> +
>>> +#include "buffer.h"
>>> +#include "error.h"
>>> +#include "win32.h"
>>> +
>>> +#include "memdbg.h"
>>> +
>>> +#include "platform.h"
>>> +
>>> +/* Redefine the top level directory of the filesystem
>>> +   to restrict access to files for security */
>>> +void
>>> +platform_chroot (const char *path)
>>> +{
>>> +  if (path)
>>> +    {
>>> +#ifdef HAVE_CHROOT
>>> +      const char *top =3D "/";
>>> +      if (chroot (path))
>>> +       msg (M_ERR, "chroot to '%s' failed", path);
>>> +      if (platform_chdir (top))
>>> +       msg (M_ERR, "cd to '%s' failed", top);
>>> +      msg (M_INFO, "chroot to '%s' and cd to '%s' succeeded", path, to=
p);
>>> +#else
>>> +      msg (M_FATAL, "Sorry but I can't chroot to '%s' because this ope=
rating system doesn't appear to support the chroot() system call", path);
>>> +#endif
>>> +    }
>>> +}
>>> +
>>> +/* Get/Set UID of process */
>>> +
>>> +bool
>>> +platform_user_get (const char *username, struct platform_state_user *s=
tate)
>>> +{
>>> +  bool ret =3D false;
>>> +  CLEAR (*state);
>>> +  if (username)
>>> +    {
>>> +#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>>> +      state->pw =3D getpwnam (username);
>>> +      if (!state->pw)
>>> +       msg (M_ERR, "failed to find UID for user %s", username);
>>> +      state->username =3D username;
>>> +      ret =3D true;
>>> +#else
>>> +      msg (M_FATAL, "cannot get UID for user %s -- platform lacks getp=
wname() or setuid() system calls", username);
>>> +#endif
>>> +    }
>>> +  return ret;
>>> +}
>>> +
>>> +void
>>> +platform_user_set (const struct platform_state_user *state)
>>> +{
>>> +#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>>> +  if (state->username && state->pw)
>>> +    {
>>> +      if (setuid (state->pw->pw_uid))
>>> +       msg (M_ERR, "setuid('%s') failed", state->username);
>>> +      msg (M_INFO, "UID set to %s", state->username);
>>> +    }
>>> +#endif
>>> +}
>>> +
>>> +/* Get/Set GID of process */
>>> +
>>> +bool
>>> +platform_group_get (const char *groupname, struct platform_state_group=
 *state)
>>> +{
>>> +  bool ret =3D false;
>>> +  CLEAR (*state);
>>> +  if (groupname)
>>> +    {
>>> +#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>>> +      state->gr =3D getgrnam (groupname);
>>> +      if (!state->gr)
>>> +       msg (M_ERR, "failed to find GID for group %s", groupname);
>>> +      state->groupname =3D groupname;
>>> +      ret =3D true;
>>> +#else
>>> +      msg (M_FATAL, "cannot get GID for group %s -- platform lacks get=
grnam() or setgid() system calls", groupname);
>>> +#endif
>>> +    }
>>> +  return ret;
>>> +}
>>> +
>>> +void
>>> +platform_group_set (const struct platform_state_group *state)
>>> +{
>>> +#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>>> +  if (state->groupname && state->gr)
>>> +    {
>>> +      if (setgid (state->gr->gr_gid))
>>> +       msg (M_ERR, "setgid('%s') failed", state->groupname);
>>> +      msg (M_INFO, "GID set to %s", state->groupname);
>>> +#ifdef HAVE_SETGROUPS
>>> +      {
>>> +        gid_t gr_list[1];
>>> +       gr_list[0] =3D state->gr->gr_gid;
>>> +       if (setgroups (1, gr_list))
>>> +         msg (M_ERR, "setgroups('%s') failed", state->groupname);
>>> +      }
>>> +#endif
>>> +    }
>>> +#endif
>>> +}
>>> +
>>> +/* Change process priority */
>>> +void
>>> +platform_nice (int niceval)
>>> +{
>>> +  if (niceval)
>>> +    {
>>> +#ifdef HAVE_NICE
>>> +      errno =3D 0;
>>> +      if (nice (niceval) < 0 && errno !=3D 0)
>>> +       msg (M_WARN | M_ERRNO, "WARNING: nice %d failed: %s", niceval, =
strerror(errno));
>>> +      else
>>> +       msg (M_INFO, "nice %d succeeded", niceval);
>>> +#else
>>> +      msg (M_WARN, "WARNING: nice %d failed (function not implemented)=
", niceval);
>>> +#endif
>>> +    }
>>> +}
>>> +
>>> +/* Get current PID */
>>> +unsigned int
>>> +platform_getpid ()
>>> +{
>>> +#ifdef WIN32
>>> +  return (unsigned int) GetCurrentProcessId ();
>>> +#else
>>> +#ifdef HAVE_GETPID
>>> +  return (unsigned int) getpid ();
>>> +#else
>>> +  return 0;
>>> +#endif
>>> +#endif
>>> +}
>>> +
>>> +/* Disable paging */
>>> +void
>>> +platform_mlockall(bool print_msg)
>>> +{
>>> +#ifdef HAVE_MLOCKALL
>>> +  if (mlockall (MCL_CURRENT | MCL_FUTURE))
>>> +    msg (M_WARN | M_ERRNO, "WARNING: mlockall call failed");
>>> +  else if (print_msg)
>>> +    msg (M_INFO, "mlockall call succeeded");
>>> +#else
>>> +  msg (M_WARN, "WARNING: mlockall call failed (function not implemente=
d)");
>>> +#endif
>>> +}
>>> +
>>> +/*
>>> + * Wrapper for chdir library function
>>> + */
>>> +int
>>> +platform_chdir (const char* dir)
>>> +{
>>> +#ifdef HAVE_CHDIR
>>> +#ifdef WIN32
>>> +  int res;
>>> +  struct gc_arena gc =3D gc_new ();
>>> +  res =3D _wchdir (wide_string (dir, &gc));
>>> +  gc_free (&gc);
>>> +  return res;
>>> +#else
>>> +  return chdir (dir);
>>> +#endif
>>> +#else
>>> +  return -1;
>>> +#endif
>>> +}
>>> +
>>> +/*
>>> + * convert system() return into a success/failure value
>>> + */
>>> +bool
>>> +platform_system_ok (int stat)
>>> +{
>>> +#ifdef WIN32
>>> +  return stat =3D=3D 0;
>>> +#else
>>> +  return stat !=3D -1 && WIFEXITED (stat) && WEXITSTATUS (stat) =3D=3D=
 0;
>>> +#endif
>>> +}
>>> +
>>> +/*
>>> + * did system() call execute the given command?
>>> + */
>>> +bool
>>> +platform_system_executed (int stat)
>>> +{
>>> +#ifdef WIN32
>>> +  return stat !=3D -1;
>>> +#else
>>> +  return stat !=3D -1 && WEXITSTATUS (stat) !=3D 127;
>>> +#endif
>>> +}
>>> +
>>> +int
>>> +platform_access (const char *path, int mode)
>>> +{
>>> +#ifdef WIN32
>>> +  struct gc_arena gc =3D gc_new ();
>>> +  int ret =3D _waccess (wide_string (path, &gc), mode & ~X_OK);
>>> +  gc_free (&gc);
>>> +  return ret;
>>> +#else
>>> +  return access (path, mode);
>>> +#endif
>>> +}
>>> +
>>> +/*
>>> + * Go to sleep for n milliseconds.
>>> + */
>>> +void
>>> +platform_sleep_milliseconds (unsigned int n)
>>> +{
>>> +#ifdef WIN32
>>> +  Sleep (n);
>>> +#else
>>> +  struct timeval tv;
>>> +  tv.tv_sec =3D n / 1000;
>>> +  tv.tv_usec =3D (n % 1000) * 1000;
>>> +  select (0, NULL, NULL, NULL, &tv);
>>> +#endif
>>> +}
>>> +
>>> +/*
>>> + * Go to sleep indefinitely.
>>> + */
>>> +void
>>> +platform_sleep_until_signal (void)
>>> +{
>>> +#ifdef WIN32
>>> +  ASSERT (0);
>>> +#else
>>> +  select (0, NULL, NULL, NULL, NULL);
>>> +#endif
>>> +}
>>> +
>>> +/* delete a file, return true if succeeded */
>>> +bool
>>> +platform_unlink (const char *filename)
>>> +{
>>> +#if defined(WIN32)
>>> +  struct gc_arena gc =3D gc_new ();
>>> +  BOOL ret =3D DeleteFileW (wide_string (filename, &gc));
>>> +  gc_free (&gc);
>>> +  return (ret !=3D 0);
>>> +#elif defined(HAVE_UNLINK)
>>> +  return (unlink (filename) =3D=3D 0);
>>> +#else
>>> +  return false;
>>> +#endif
>>> +}
>>> +
>>> +int platform_system(const char *command) {
>>> +  int ret;
>>> +#ifdef WIN32
>>> +  struct gc_arena gc =3D gc_new ();
>>> +  ret =3D _wsystem (wide_string (command, &gc));
>>> +  gc_free (&gc);
>>> +#else
>>> +  ret =3D system (command);
>>> +#endif
>>> +  return ret;
>>> +}
>>> +
>>> +int platform_putenv(char *string)
>>> +{
>>> +  int status;
>>> +#if defined(WIN32)
>>> +  struct gc_arena gc =3D gc_new ();
>>> +  char *s =3D string_alloc(string, &gc);
>>> +  char *value =3D strchr(s, '=3D');
>>> +  if (value!=3DNULL)
>>> +    {
>>> +      *value =3D '\0';
>>> +      value++;
>>> +      if (*value =3D=3D '\0')
>>> +        value =3D NULL;
>>> +    }
>>> +
>>> +  status =3D SetEnvironmentVariableW (wide_string (s, &gc),
>>> +      wide_string (value, &gc)) ? 1: 0;
>>> +  gc_free (&gc);
>>> +#elif defined(HAVE_PUTENV)
>>> +  void manage_env (char *str); /* TODO: Resolve properly */
>>> +  status =3D putenv (string);
>>> +  if (!status)
>>> +    manage_env (string);
>>> +#endif
>>> +
>>> +  return status;
>>> +}
>>> +
>>> +FILE *
>>> +platform_fopen (const char *path, const char *mode)
>>> +{
>>> +#ifdef WIN32
>>> +  struct gc_arena gc =3D gc_new ();
>>> +  FILE *f =3D _wfopen (wide_string (path, &gc), wide_string (mode, &gc=
));
>>> +  gc_free (&gc);
>>> +  return f;
>>> +#else
>>> +  return fopen(path, mode);
>>> +#endif
>>> +}
>>> +
>>> +int
>>> +platform_open (const char *path, int flags, int mode)
>>> +{
>>> +#ifdef WIN32
>>> +  struct gc_arena gc =3D gc_new ();
>>> +  int fd =3D _wopen (wide_string (path, &gc), flags, mode);
>>> +  gc_free (&gc);
>>> +  return fd;
>>> +#else
>>> +  return open(path, flags, mode);
>>> +#endif
>>> +}
>>> +
>>> +int
>>> +platform_stat (const char *path, platform_stat_t *buf)
>>> +{
>>> +#ifdef WIN32
>>> +  struct gc_arena gc =3D gc_new ();
>>> +  int res =3D _wstat (wide_string (path, &gc), buf);
>>> +  gc_free (&gc);
>>> +  return res;
>>> +#else
>>> +  return stat(path, buf);
>>> +#endif
>>> +}
>>> +
>>> diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
>>> new file mode 100644
>>> index 0000000..7bd2067
>>> --- /dev/null
>>> +++ b/src/openvpn/platform.h
>>> @@ -0,0 +1,142 @@
>>> +/*
>>> + *  OpenVPN -- An application to securely tunnel IP networks
>>> + *             over a single TCP/UDP port, with support for SSL/TLS-ba=
sed
>>> + *             session authentication and key exchange,
>>> + *             packet encryption, packet authentication, and
>>> + *             packet compression.
>>> + *
>>> + *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...1699...=
.>
>>> + *
>>> + *  This program is free software; you can redistribute it and/or modi=
fy
>>> + *  it under the terms of the GNU General Public License version 2
>>> + *  as published by the Free Software Foundation.
>>> + *
>>> + *  This program is distributed in the hope that it will be useful,
>>> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + *  GNU General Public License for more details.
>>> + *
>>> + *  You should have received a copy of the GNU General Public License
>>> + *  along with this program (see the file COPYING included with this
>>> + *  distribution); if not, write to the Free Software Foundation, Inc.,
>>> + *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>>> + */
>>> +
>>> +#ifndef PLATFORM_H
>>> +#define PLATFORM_H
>>> +
>>> +#ifdef HAVE_SYS_TYPES_H
>>> +#include <sys/types.h>
>>> +#endif
>>> +
>>> +#ifdef HAVE_SYS_STAT_H
>>> +#include <sys/stat.h>
>>> +#endif
>>> +
>>> +#ifdef HAVE_UNISTD_H
>>> +#include <unistd.h>
>>> +#endif
>>> +
>>> +#ifdef HAVE_PWD_H
>>> +#include <pwd.h>
>>> +#endif
>>> +
>>> +#ifdef HAVE_GRP_H
>>> +#include <grp.h>
>>> +#endif
>>> +
>>> +#ifdef HAVE_STDIO_H
>>> +#include <stdio.h>
>>> +#endif
>>> +
>>> +#include "basic.h"
>>> +
>>> +/* Get/Set UID of process */
>>> +
>>> +struct platform_state_user {
>>> +#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>>> +  const char *username;
>>> +  struct passwd *pw;
>>> +#else
>>> +  int dummy;
>>> +#endif
>>> +};
>>> +
>>> +/* Get/Set GID of process */
>>> +
>>> +struct platform_state_group {
>>> +#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>>> +  const char *groupname;
>>> +  struct group *gr;
>>> +#else
>>> +  int dummy;
>>> +#endif
>>> +};
>>> +
>>> +bool platform_user_get (const char *username, struct platform_state_us=
er *state);
>>> +void platform_user_set (const struct platform_state_user *state);
>>> +
>>> +bool platform_group_get (const char *groupname, struct platform_state_=
group *state);
>>> +void platform_group_set (const struct platform_state_group *state);
>>> +
>>> +/*
>>> + * Extract UID or GID
>>> + */
>>> +
>>> +static inline int
>>> +platform_state_user_uid (const struct platform_state_user *s)
>>> +{
>>> +#if defined(HAVE_GETPWNAM) && defined(HAVE_SETUID)
>>> +  if (s->pw)
>>> +    return s->pw->pw_uid;
>>> +#endif
>>> +  return -1;
>>> +}
>>> +
>>> +static inline int
>>> +platform_state_group_gid (const struct platform_state_group *s)
>>> +{
>>> +#if defined(HAVE_GETGRNAM) && defined(HAVE_SETGID)
>>> +  if (s->gr)
>>> +    return s->gr->gr_gid;
>>> +#endif
>>> +  return -1;
>>> +}
>>> +
>>> +void platform_chroot (const char *path);
>>> +
>>> +void platform_nice (int niceval);
>>> +
>>> +unsigned int platform_getpid (void);
>>> +
>>> +void platform_mlockall (bool print_msg); /* Disable paging */
>>> +
>>> +int platform_chdir (const char* dir);
>>> +
>>> +/* interpret the status code returned by system()/execve() */
>>> +bool platform_system_ok (int stat);
>>> +bool platform_system_executed (int stat);
>>> +int platform_system(const char *command);
>>> +
>>> +int platform_access (const char *path, int mode);
>>> +
>>> +void platform_sleep_milliseconds (unsigned int n);
>>> +
>>> +void platform_sleep_until_signal (void);
>>> +
>>> +/* delete a file, return true if succeeded */
>>> +bool platform_unlink (const char *filename);
>>> +
>>> +int platform_putenv (char *string);
>>> +
>>> +FILE *platform_fopen (const char *path, const char *mode);
>>> +int platform_open (const char *path, int flags, int mode);
>>> +
>>> +#ifdef WIN32
>>> +typedef struct _stat platform_stat_t;
>>> +#else
>>> +typedef struct stat platform_stat_t;
>>> +#endif
>>> +int platform_stat (const char *path, platform_stat_t *buf);
>>> +
>>> +#endif
>>> diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
>>> index a4e50e8..5d056ee 100644
>>> --- a/src/openvpn/ps.c
>>> +++ b/src/openvpn/ps.c
>>> @@ -337,7 +337,7 @@ journal_add (const char *journal_dir, struct proxy_=
connection *pc, struct proxy_
>>>        check_malloc_return (jfn);
>>>        openvpn_snprintf (jfn, fnlen, "%s/%s", journal_dir, t);
>>>        dmsg (D_PS_PROXY_DEBUG, "PORT SHARE PROXY: client origin %s -> %=
s", jfn, f);
>>> -      fd =3D openvpn_open (jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR =
| S_IWUSR | S_IRGRP);
>>> +      fd =3D platform_open (jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR=
 | S_IWUSR | S_IRGRP);
>>>        if (fd !=3D -1)
>>>         {
>>>           write(fd, f, strlen(f));
>>> diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
>>> index 6a60cb5..d712c66 100644
>>> --- a/src/openvpn/ssl_openssl.c
>>> +++ b/src/openvpn/ssl_openssl.c
>>> @@ -280,7 +280,7 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const=
 char *pkcs12_file,
>>>  #endif
>>>      {
>>>        /* Load the PKCS #12 file */
>>> -      if (!(fp =3D openvpn_fopen(pkcs12_file, "rb")))
>>> +      if (!(fp =3D platform_fopen(pkcs12_file, "rb")))
>>>         msg(M_SSLERR, "Error opening file %s", pkcs12_file);
>>>        p12 =3D d2i_PKCS12_fp(fp, NULL);
>>>        fclose(fp);
>>> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
>>> index 51457f8..e837e39 100644
>>> --- a/src/openvpn/ssl_verify.c
>>> +++ b/src/openvpn/ssl_verify.c
>>> @@ -517,7 +517,7 @@ verify_cert_call_command(const char *verify_command=
, struct env_set *es,
>>>    if (verify_export_cert)
>>>      {
>>>         if (tmp_file)
>>> -          delete_file(tmp_file);
>>> +          platform_unlink(tmp_file);
>>>      }
>>>
>>>    gc_free(&gc);
>>> @@ -551,7 +551,7 @@ verify_check_crl_dir(const char *crl_dir, openvpn_x=
509_cert_t *cert)
>>>        x509_free_serial(serial);
>>>        return FAILURE;
>>>      }
>>> -  fd =3D openvpn_open (fn, O_RDONLY, 0);
>>> +  fd =3D platform_open (fn, O_RDONLY, 0);
>>>    if (fd >=3D 0)
>>>      {
>>>        msg (D_HANDSHAKE, "VERIFY CRL: certificate serial number %s is r=
evoked", serial);
>>> @@ -735,7 +735,7 @@ key_state_rm_auth_control_file (struct key_state *k=
s)
>>>  {
>>>    if (ks && ks->auth_control_file)
>>>      {
>>> -      delete_file (ks->auth_control_file);
>>> +      platform_unlink (ks->auth_control_file);
>>>        free (ks->auth_control_file);
>>>        ks->auth_control_file =3D NULL;
>>>      }
>>> @@ -987,7 +987,7 @@ verify_user_pass_script (struct tls_session *sessio=
n, const struct user_pass *up
>>>
>>>   done:
>>>    if (tmp_file && strlen (tmp_file) > 0)
>>> -    delete_file (tmp_file);
>>> +    platform_unlink (tmp_file);
>>>
>>>    argv_reset (&argv);
>>>    gc_free (&gc);
>>> diff --git a/src/openvpn/status.c b/src/openvpn/status.c
>>> index 0be5e4c..5f9ab9e 100644
>>> --- a/src/openvpn/status.c
>>> +++ b/src/openvpn/status.c
>>> @@ -78,17 +78,17 @@ status_open (const char *filename,
>>>            switch (so->flags)
>>>              {
>>>              case STATUS_OUTPUT_WRITE:
>>> -              so->fd =3D openvpn_open (filename,
>>> +              so->fd =3D platform_open (filename,
>>>                                       O_CREAT | O_TRUNC | O_WRONLY,
>>>                                       S_IRUSR | S_IWUSR);
>>>                break;
>>>              case STATUS_OUTPUT_READ:
>>> -              so->fd =3D openvpn_open (filename,
>>> +              so->fd =3D platform_open (filename,
>>>                                       O_RDONLY,
>>>                                       S_IRUSR | S_IWUSR);
>>>                break;
>>>              case STATUS_OUTPUT_READ|STATUS_OUTPUT_WRITE:
>>> -              so->fd =3D openvpn_open (filename,
>>> +              so->fd =3D platform_open (filename,
>>>                                       O_CREAT | O_RDWR,
>>>                                       S_IRUSR | S_IWUSR);
>>>                break;
>>> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
>>> index abc6a99..e6a7bc8 100644
>>> --- a/src/openvpn/tun.c
>>> +++ b/src/openvpn/tun.c
>>> @@ -1545,22 +1545,22 @@ tuncfg (const char *dev, const char *dev_type, =
const char *dev_node, int persist
>>>      msg (M_ERR, "Cannot ioctl TUNSETPERSIST(%d) %s", persist_mode, dev=
);
>>>    if (username !=3D NULL)
>>>      {
>>> -      struct user_state user_state;
>>> +      struct platform_state_user platform_state_user;
>>>
>>> -      if (!get_user (username, &user_state))
>>> +      if (!platform_user_get (username, &platform_state_user))
>>>          msg (M_ERR, "Cannot get user entry for %s", username);
>>>        else
>>> -        if (ioctl (tt->fd, TUNSETOWNER, user_state.pw->pw_uid) < 0)
>>> +        if (ioctl (tt->fd, TUNSETOWNER, platform_state_user.pw->pw_uid=
) < 0)
>>>            msg (M_ERR, "Cannot ioctl TUNSETOWNER(%s) %s", username, dev=
);
>>>      }
>>>    if (groupname !=3D NULL)
>>>      {
>>> -      struct group_state group_state;
>>> +      struct platform_state_group platform_state_group;
>>>
>>> -      if (!get_group (groupname, &group_state))
>>> +      if (!platform_group_get (groupname, &platform_state_group))
>>>          msg (M_ERR, "Cannot get group entry for %s", groupname);
>>>        else
>>> -        if (ioctl (tt->fd, TUNSETGROUP, group_state.gr->gr_gid) < 0)
>>> +        if (ioctl (tt->fd, TUNSETGROUP, platform_state_group.gr->gr_gi=
d) < 0)
>>>            msg (M_ERR, "Cannot ioctl TUNSETOWNER(%s) %s", groupname, de=
v);
>>>      }
>>>    close_tun (tt);
>>> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
>>> index e94343b..e8e69dc 100644
>>> --- a/src/openvpn/win32.c
>>> +++ b/src/openvpn/win32.c
>>> @@ -976,33 +976,6 @@ wide_string (const char* utf8, struct gc_arena *gc)
>>>    return ucs16;
>>>  }
>>>
>>> -FILE *
>>> -openvpn_fopen (const char *path, const char *mode)
>>> -{
>>> -  struct gc_arena gc =3D gc_new ();
>>> -  FILE *f =3D _wfopen (wide_string (path, &gc), wide_string (mode, &gc=
));
>>> -  gc_free (&gc);
>>> -  return f;
>>> -}
>>> -
>>> -int
>>> -openvpn_open (const char *path, int flags, int mode)
>>> -{
>>> -  struct gc_arena gc =3D gc_new ();
>>> -  int fd =3D _wopen (wide_string (path, &gc), flags, mode);
>>> -  gc_free (&gc);
>>> -  return fd;
>>> -}
>>> -
>>> -int
>>> -openvpn_stat (const char *path, openvpn_stat_t *buf)
>>> -{
>>> -  struct gc_arena gc =3D gc_new ();
>>> -  int res =3D _wstat (wide_string (path, &gc), buf);
>>> -  gc_free (&gc);
>>> -  return res;
>>> -}
>>> -
>>>  /*
>>>   * call ourself in another process
>>>   */
>>> --
>>> 1.7.3.4
>>>
>>>
>>> -----------------------------------------------------------------------=
-------
>>> Virtualization & Cloud Management Using Capacity Planning
>>> Cloud computing makes use of virtualization - but cloud computing
>>> also focuses on allowing computing to be delivered as a service.
>>> http://www.accelacomm.com/jaw/sfnl/114/51521223/
>>> _______________________________________________
>>> Openvpn-devel mailing list
>>> Openvpn-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>


