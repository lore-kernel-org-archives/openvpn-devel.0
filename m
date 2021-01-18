From: Gert Doering <gert@...1296...>
Date: Mon, 18 Jan 2021 13:15:29 +0100
Message-Id: <20210118121529.16579-1-gert@...1296...>
In-Reply-To: <20201225192621.28592-1-gert@...1296...>
References: <20201225192621.28592-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Document common uses of 'echo' directive,
 re-enable logging for 'echo'.
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

The 'echo' command can be used to signal information to an OpenVPN
GUI driving the openvpn core via management interface.  Which commands
exists and their syntax has so far been mostly undocumented.

Condense the long and good discussion between Selva Nair and
Jonathan K. Bullard into doc/gui-notes.txt (initial draft from
Jonathan, comments from Selva and Arne), with a pointer added
to doc/management-notes.txt.

See:

https://sourceforge.net/p/openvpn/mailman/openvpn-users/thread/CAEsd45T%2Bd6FUJ9Po0KHwtHjfuL9Q2D-poG8yFtY45Qyh%2BtHjkg%40mail.gmail.com/#msg36136236

and

https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA%40mail.gmail.com/#msg36141193

for the details.

Re-enable logging of 'echo' statements, but only for the particular
class of messages starting with 'echo msg...'.

v2:
  incorporate feedback from Selva Nair, correct >ECHO examples

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/Makefile.am          |   2 +-
 doc/gui-notes.txt        | 366 +++++++++++++++++++++++++++++++++++++++
 doc/management-notes.txt |  10 ++
 src/openvpn/options.c    |  15 +-
 4 files changed, 385 insertions(+), 8 deletions(-)
 create mode 100644 doc/gui-notes.txt

diff --git a/doc/Makefile.am b/doc/Makefile.am
index df2f54a3..e411f5f9 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -15,7 +15,7 @@ MAINTAINERCLEANFILES = \
 SUBDIRS = doxygen
 
 dist_doc_DATA = \
-	management-notes.txt
+	management-notes.txt gui-notes.txt
 
 dist_noinst_DATA = \
 	README.plugins interactive-service-notes.rst \
diff --git a/doc/gui-notes.txt b/doc/gui-notes.txt
new file mode 100644
index 00000000..4d993484
--- /dev/null
+++ b/doc/gui-notes.txt
@@ -0,0 +1,366 @@
+Management Interface "echo" protocol
+
+================================================================================
+THIS IS A PRELIMINARY VERSION OF THIS DOCUMENT. ALL INFORMATION IN IT
+IS SUBJECT TO CHANGE.
+================================================================================
+
+
+    CONTENTS
+        THE OPENVPN --ECHO OPTION
+        ENVIRONMENT COMMAND
+        MESSSAGE COMMANDS
+        PASSWORD COMMANDS
+        QUOTING
+        COMMMAND DETAILS
+
+
+=========================
+THE OPENVPN --ECHO OPTION
+=========================
+
+The OpenVPN --echo option causes commands to be sent out through the
+management interface, typically to a Graphic User Interface (GUI) such
+as "OpenVPN for Android", "Tunnelblick" (for macOS), or "Windows
+OpenVPN GUI". It can be included in a configuration file or on a
+command line, or can be pushed from the server.
+
+This document describes the commands that can be sent and how they are
+interpreted by various GUIs.
+
+ * OpenVPN does not process the commands in an --echo option; it only
+sends them out through the management interface.
+
+ * "echo" commands are processed by the GUI if, as, when, and in the
+order they are received. If no GUI is present the processing of
+commands may be delayed, the commands may never be processed, or only
+some commands may be processed. (That can happen if OpenVPN discards
+commands because its buffer for the commands fills up.)
+
+ * There is no mechanism for the GUI to acknowledge the receipt,
+success, or failure of a command.
+
+ * "echo" commands are stored by OpenVPN (within limits, see the next
+point) and sent only when the GUI requests them through the management
+interface. "echo" commands in the configuration file or the command
+line are typically requested and processed at the start of a
+connection attempt. "echo" commands that are pushed by the server are
+also typically asked for at the start of a connection attempt but can
+be sent at any time. They are processed in the middle of a connection
+attempt or after a connection is established, as the "push" options
+are received by the client from the server.
+
+  * OpenVPN's storage for echo commands is limited in size, so a large
+number of commands or commands with long messages may require that
+some commands be removed from the storage. If that happens, some of
+the commands may not be sent through the management interface when a
+GUI does connect to it or asks for the "echo" commands.
+
+ * On SIGUSR1 and SIGHUP connection restarts, "echo" commands that
+were sent through the management interface and have been saved by
+OpenVPN are sent again and will be re-processed by the GUI. (The
+message commands include a mechanism for muting (skipping) duplicate
+messages, see MESSAGE COMMANDS, below.)
+
+ * OpenVPN limits the number of separate arguments in each line of a
+configuration file. Arguments may be quoted to work around this
+limitation, see QUOTING, below.
+
+ * OpenVPN limits the size of each "echo" command sent over the
+management interface to 255 bytes, including overhead characters. To
+allow messages of arbitrary length, several message commands can be
+concatenated together before being displayed to the user, see MESSAGE
+COMMANDS, below.
+
+ * There no indication to the GUI of the source of the command
+(configuration file, command line option, or pushed from a server). It
+might be possible for the GUI to deduce that a command was pushed from
+a server because of timing or other management interface interactions.
+
+
+===================
+ENVIRONMENT COMMAND
+===================
+
+Typically, a GUI allows users to specify shell commands (typically
+scripts) to run at certain points in the connection/disconnection
+process, in addition to those provided by OpenVPN options such as
+"--up" and "--down".
+
+The "setenv" command can be used to set environment variables that are
+available to the scripts run by the GUI. Each "setenv" command
+specifies a value for one environment variable that is available to
+the scripts that the GUI runs.
+
+This is similar to Openvpn's "--setenv" option, which specifies an
+additional environment variable that is included in the environment
+variables that are available to the scripts that OpenVPN runs.
+
+
+=================
+MESSSAGE COMMANDS
+=================
+
+Four commands can be used to display a message to the user from the
+OpenVPN configuration or server:
+
+    msg
+    msg-n
+    msg-window
+    msg-notify
+
+"msg" and "msg-n" commands are concatenated to construct a message.
+When a "msg-window"or "msg-notify" command is received the message is
+displayed to the user.
+
+Identical messages (same title, text, and destination) received during
+one connection may be ignored or muted. Some GUIs may only show the
+first message for a connection, or the first message shown in a window
+and the first message shown as a notification.
+
+
+=================
+PASSWORD COMMANDS
+=================
+
+Three commands can be used to control the GUI's storage of usernames,
+passwords, and private keys:
+
+    disable-save-passwords
+    forget-passwords
+    save-passwords
+
+
+=======
+QUOTING
+=======
+
+ * In a configuration file, the rest of the line is parsed into
+separate arguments  and then 'echo' and the arguments are passed, each
+separated by a single space, through the management interface. For
+example:
+
+    echo     argument1 argument2
+    echo    "     argument1      argument2"
+
+will be sent through the management interface as
+
+    >ECHO:timestamp,argument1 argument2
+    >ECHO:timestamp,     argument1      argument2
+
+ * In a command line option, the single argument following "--echo" is
+parsed similarly, so
+
+    --echo   argument1     argument2
+    --echo   "    argument1     argument2"
+
+will be sent through the management interface as
+
+    >ECHO:timestamp,argument1 argument2
+    >ECHO:timestamp,     argument1      argument2
+
+ * In a "push" option in a server configuration file, the single
+option following "push" is parsed similarly, so
+
+    push "echo argument1 argument2 argument3   argument4"
+    push "echo '    argument1 argument2 argument3   argument4'"
+
+will be sent through the management interface as
+
+    >ECHO:timestamp,argument1 argument2 argument3 argument4
+    >ECHO:timestamp,     argument1 argument2 argument3   argument4
+
+
+================
+COMMMAND DETAILS
+================
+
+
+COMMAND -- disable-save-passwords
+---------------------------------
+
+Syntax: disable-save-passwords
+
+The GUI is instructed to not allow the user to save passwords or
+private keys for the configuration. The user is still allowed to save
+usernames. Any passwords or private keys that have been saved will be
+forgotten.
+
+This command will be effective at startup only if present in the
+configuration file or as a command line option. If pushed from the
+server, saving passwords will be disabled in password prompts only
+after the initial prompt has been shown to the user.
+
+    Android: ??????
+
+    Tunnelblick: Planned. This command will disable saving of
+passwords or private keys and forget any saved usernames, passwords,
+or private keys regardless of the normal (non-forced) global or
+per-configuration settings. A computer administrator can "force" this
+setting, overriding this command.
+
+    Windows OpenVPN GUI: Planned. This command will disable saving of
+passwords or private keys and forget any saved usernames, passwords,
+or private keys regardless of any global settings.
+
+
+COMMAND -- forget-passwords
+---------------------------
+
+Syntax: forget-passwords
+
+The GUI is instructed to forget any usernames, passwords, and private
+keys it has saved for the configuration. Useful when pushed from the
+server so that it is processed after authentication.
+
+    Android: ??????
+
+    Tunnelblick: Planned.
+
+    Windows OpenVPN GUI: supported since release 2.4.1 (GUI version 11.5.0)
+
+
+COMMAND -- msg
+--------------
+
+Syntax: msg text
+
+The text is appended to any previous text from "msg" or "msg-n"
+commands, and a newline is appended after that.
+
+A trailing newline will be removed from the completed message before
+it is displayed to the user.
+
+The text may include any UTF-8 character except a comma (","), CR
+(0x0D), LF (0x0A), or NUL (0x00).
+
+The text may not contain percent ("%") except in "percent encoding"
+sequences. To display a percent sign, use %25.
+
+The text may not contain commas (",") because of constraints imposed
+by OpenVPN. Commas should be encoded using "percent encoding" (URL
+encoding): a '%' character followed by two hexadecimal digits, the
+high- and then low-nibble of the ASCII code for the character to be
+shown. Examples: a comma is encoded as %2C or %2c; a percent sign is
+encoded as %25.
+
+Text containing comment characters # and ; must be enclosed in quotes to
+survive after option parsing by openvpn.
+
+The insertion of line endings (CR, LF) in the text is discouraged
+because it is OS dependent. Instead, use the "msg" command, which
+appends a line ending appropriate for the OS on which the GUI is
+running.
+
+    Android: ??????
+
+    Tunnelblick: Planned.
+
+    Windows OpenVPN GUI: Planned.
+
+COMMAND -- msg-n
+----------------
+
+Syntax: msg-n text
+
+The text is appended to any previous text from "msg"" or "msg-n""
+commands. (Like "msg" except that no newline is appended.)
+
+See "COMMAND -- msg" for details about "text".
+
+    Android: ??????
+
+    Tunnelblick: Planned.
+
+    Windows OpenVPN GUI: Planned.
+
+COMMAND -- msg-notify
+---------------------
+
+Syntax: msg-notify title
+
+The text from previous "msg" and/or "msg-n" commands is displayed to
+the user as a notification with title "title" and the previous text is
+forgotten.
+
+    Android: ??????
+
+    Tunnelblick: Planned.
+
+    Windows OpenVPN GUI: Planned.
+
+Note: The max length that will correctly display as a notification
+message is OS dependent.
+
+
+COMMAND -- msg-window title
+---------------------------
+
+Syntax: msg-window title
+
+The text from previous "msg" and/or "msg-n" commands is displayed to
+the user in a non-modal popup window with title "title" and the
+previous text is forgotten.  How the title is displayed exactly is left
+to the implementation. Could be set as the window title or as a
+differently formatted text as the heading of the message, for example.
+
+    Android: ??????
+
+    Tunnelblick: Planned.
+
+    Windows OpenVPN GUI: Planned.
+
+
+COMMAND -- save-passwords
+-------------------------
+
+Syntax: save-passwords
+
+The GUI is instructed to allow the user to save usernames, passwords
+and private keys for the configuration.
+
+This command will be effective at startup only if present in the
+configuration file or as a command line option. If pushed from the
+server, saving passwords will be allowed in password prompts only
+after the initial prompt has been shown to the user.
+
+This command typically has the effect of presenting the password
+dialogs to the user with a "save password" checkbox checked. The user
+may still uncheck it during the dialog.
+
+    Android: ??????
+
+    Tunnelblick: Planned. Tunnelblick ignores this command. Usernames,
+passwords, and private keys may be saved by default, and this command
+will not override the separate Tunnelblick global or per-configuration
+settings used to disable saving them.
+
+    Windows OpenVPN GUI: Supported since release 2.4.1 (GUI version 11.5.0)
+
+
+COMMAND -- setenv
+-----------------
+
+Syntax: setenv name value
+
+Sets an environment variable that will be available to the scripts run
+by the GUI.
+
+This will set environment variable "OPENVPN_name" to value "value" for
+the scripts run by the GUI. "name" is changed to "OPENVPN_name" to
+prevent overwriting sensitive variables such as PATH. Variables are
+set in the order received, with later values replacing earlier ones
+for the same "name".
+
+Names may include only alphanumeric characters and underscores. A
+"setenv" command with an invalid name will be ignored.
+
+    Android: ??????
+
+    Tunnelblick: Planned.
+
+    Windows OpenVPN GUI: supported since release v2.4.7 (GUI version v11.12.0)
+The variables set by "setenv" are merged with those for the process
+environment.  In case of duplicate names the one in the setenv list is
+chosen.
+
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 61daaf07..50f0f567 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -137,6 +137,16 @@ history while simultaneously activating real-time updates:
 The size of the echo buffer is currently hardcoded to 100
 messages.
 
+
+Generally speaking, the OpenVPN Core does not understand echo
+messages at all (so a cooperating GUI and Server can use this
+mechanism for arbitrary information transport).
+
+This said, a few echo commands have been agreed upon between the
+community maintained OpenVPN Windows GUI and Tunnelblick for MacOS,
+and documentation of these can be found in doc/gui-notes.txt.
+
+
 COMMAND -- exit, quit
 ---------------------
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ff3954d5..36009f4f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5306,13 +5306,14 @@ add_option(struct options *options,
         }
         if (good)
         {
-#if 0
-            /* removed for now since ECHO can potentially include
-             * security-sensitive strings */
-            msg(M_INFO, "%s:%s",
-                pull_mode ? "ECHO-PULL" : "ECHO",
-                BSTR(&string));
-#endif
+            /* only message-related ECHO are logged, since other ECHOs
+             * can potentially include security-sensitive strings */
+            if (strncmp(p[1],"msg",3) == 0)
+            {
+                msg(M_INFO, "%s:%s",
+                    pull_mode ? "ECHO-PULL" : "ECHO",
+                    BSTR(&string));
+            }
 #ifdef ENABLE_MANAGEMENT
             if (management)
             {
-- 
2.26.2


