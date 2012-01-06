Message-ID: <4F071FD7.3060201@...1114...>
Date: Fri, 06 Jan 2012 17:22:47 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1320075008.29689.31.camel@...1520...>
	<4EAF0EFD.6060106@...1114...>
	<1323712625.31471.4.camel@...1520...>
In-Reply-To: <1323712625.31471.4.camel@...1520...>
Subject: Re: [Openvpn-devel] [PATCH] adding support for systemd tty console
 wrapper
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Frederic Crozat <fcrozat@...1519...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/12/11 18:57, Frederic Crozat wrote:
> Le lundi 31 octobre 2011 à 22:11 +0100, David Sommerseth a écrit :
>> On 31/10/11 16:30, Frederic Crozat wrote:
[...snip...]

Hey again, and thanks for this great rework!  I've looked through it, and
it looks a lot better now.  However ...

>> e) Consider to make use of openvpn_execve_check() or
>> openvpn_execve() instead of the popen() - or make a popen() variant
>> which got similar error controls to popen() as openvpn_execve*()
>> functions.  I also think that this execution should honour the
>> --script-security setting (which is implicitly checked for with
>> openvpn_execve())

I like the approach of the openvpn_popen().  However, there are a few things.

+              if (pipe(pipe_stdout) == 0) {
+		      pid = fork ();
+		      if (pid == (pid_t)0) /* child side */
+			{
+			  close(pipe_stdout[0]);
+			  dup2(pipe_stdout[1],1);
+			  execve (cmd, argv, envp);
+			  exit (127);
+			}
+		      else if (pid < (pid_t)0) /* fork failed */
+			;
                       ^^^^^  No error message if fork() fails?
                              And is the (pid_t) typecasting really needed?

+		      else /* parent side */
+			{
+                            ret=pipe_stdout[0];
+			    close(pipe_stdout[1]);
+			}
+	      }

And:

+  else
+    {
+      msg (M_WARN, "openvpn_popen: called with empty argv");
+    }

This should probably be M_FATAL and not M_WARN.  If openvpn_popen()
receives an empty argv array, it most likely is due to very bad
programming.  So halting execution is quite appropriate in my eyes.

In get_console_input_systemd() you do:

+  *input = 0;

I think it would be better to do: CLEAR(*input) instead.  Just setting
the first byte to 0, will not solve any leak possibilities.  An
alternative is to use memset() directly, which the CLEAR() macro uses
(see basic.h:47), but we prefer to use CLEAR() over memset() directly.

Otherwise, this looks like a very good step forward!


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk8HH9UACgkQDC186MBRfrosswCeNlaBSo4owmkt7rsWEKJOXK4u
O3kAnjV+sCKDtMJC5AtN+vHQDwmC48ya
=J8dX
-----END PGP SIGNATURE-----

