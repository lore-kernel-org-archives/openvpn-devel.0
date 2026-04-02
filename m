From: Frank Lichtenheld <frank@...2641...>
Date: Thu,  2 Apr 2026 14:04:35 +0200
Message-ID: <20260402120435.39983-1-frank@...2641...>
In-Reply-To: <gerrit.1775126506000.Ieaaf3a79642c8f7914f9bfc6762ad601c4f5695b@...2715...>
References: <gerrit.1775126506000.Ieaaf3a79642c8f7914f9bfc6762ad601c4f5695b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] doc: Remove some explanations for
 pre-2.3 configurations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Arne Schwabe <arne-openvpn@...1227...>

Just streamline the documentation a bit.

Change-Id: Ieaaf3a79642c8f7914f9bfc6762ad601c4f5695b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1603
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1603
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index 8132b48..415b81f 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -43,11 +43,11 @@
   however complications can result when scripts or restarts are executed
   after the chroot operation.
 
-  Note: The SSL library will probably need /dev/urandom to be available
+  Note: The SSL library will probably need ``/dev/urandom`` to be available
   inside the chroot directory ``dir``. This is because SSL libraries
   occasionally need to collect fresh randomness. Newer linux kernels and some
   BSDs implement a getrandom() or getentropy() syscall that removes the
-  need for /dev/urandom to be available.
+  need for ``/dev/urandom`` to be available.
 
 --compat-mode version
   This option provides a convenient way to alter the defaults of OpenVPN
@@ -170,9 +170,7 @@
   Note: as soon as OpenVPN has daemonized, it can not ask for usernames,
   passwords, or key pass phrases anymore. This has certain consequences,
   namely that using a password-protected private key will fail unless the
-  ``--askpass`` option is used to tell OpenVPN to ask for the pass phrase
-  (this requirement is new in v2.3.7, and is a consequence of calling
-  daemon() before initializing the crypto layer).
+  ``--askpass`` option is used to tell OpenVPN to ask for the pass phrase.
 
   Further, using ``--daemon`` together with ``--auth-user-pass`` (entered
   on console) and ``--auth-nocache`` will fail as soon as key
@@ -330,32 +328,22 @@
   OpenVPN releases before v2.3 also supported a ``method`` flag which
   indicated how OpenVPN should call external commands and scripts. This
   could be either :code:`execve` or :code:`system`. As of OpenVPN 2.3, this
-  flag is no longer accepted. In most \*nix environments the execve()
-  approach has been used without any issues.
+  flag is no longer accepted.
 
   Some directives such as ``--up`` allow options to be passed to the
   external script. In these cases make sure the script name does not
   contain any spaces or the configuration parser will choke because it
   can't determine where the script name ends and script options start.
 
-  To run scripts in Windows in earlier OpenVPN versions you needed to
-  either add a full path to the script interpreter which can parse the
-  script or use the ``system`` flag to run these scripts. As of OpenVPN
-  2.3 it is now a strict requirement to have full path to the script
+  On Windoes it is a strict requirement to have the full path to the script
   interpreter when running non-executables files. This is not needed for
   executable files, such as .exe, .com, .bat or .cmd files. For example,
-  if you have a Visual Basic script, you must use this syntax now:
-
-  ::
+  if you have a Visual Basic script, you must use this syntax::
 
      --up 'C:\\Windows\\System32\\wscript.exe C:\\Program\ Files\\OpenVPN\\config\\my-up-script.vbs'
 
   Please note the single quote marks and the escaping of the backslashes
-  (\\) and the space character.
-
-  The reason the support for the :code:`system` flag was removed is due to
-  the security implications with shell expansions when executing scripts
-  via the :code:`system()` call.
+  (``\\``) and the space character.
 
 --setcon context
   Apply SELinux ``context`` after initialization. This essentially

