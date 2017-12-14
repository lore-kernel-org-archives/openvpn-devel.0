MIME-Version: 1.0
In-Reply-To: <CAEsd45RuUdghAHqSS5MGSO9YaLN_vmrpjLmAASU3WrWTo_uRdw@...278...>
References: <CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA@...278...>
 <56fd237f-ba3f-c65d-9831-bf75d4dd139d@...1227...>
 <CAKuzo_gAZSaVvfSiaZSHC5ESXJ2Q8mEBPq6oV6Wk+AfDidqoXA@...278...>
 <CAEsd45QPMD57_L-yWHORqumv_-MT6rjC++FVCDRos9F0tTvMvw@...278...>
 <CAEsd45RuUdghAHqSS5MGSO9YaLN_vmrpjLmAASU3WrWTo_uRdw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 14 Dec 2017 15:03:01 -0500
Message-ID: <CAKuzo_jk0xuWtpOORy7Rovnz=g4W3ck3eOGcUg6uSTyfhvnxqA@...278...>
Subject: Re: [Openvpn-devel] Follow up on sending messages to the GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi Jon,

Thanks for starting this process.

On Thu, Dec 14, 2017 at 10:42 AM, Jonathan K. Bullard
<jkbullard@...277...> wrote:
> Hi,
>
> On Sat, Dec 2, 2017 at 7:08 AM, Jonathan K. Bullard <jkbullard@...277...> wrote:
>> Hi,
>>
>> On Fri, Dec 1, 2017 at 10:58 AM, Selva Nair <selva.nair@...277...> wrote:

...snipped..

>> I'll be happy to try to document the protocol between OpenVPN and the
>> GUI, including the "msg*" commands and others such as
>> "forget-passwords", "setenv", etc., which we've discussed. However,
>> I'm thinking it should be a separate "doc/gui-notes.txt" document.
>>
>> In a separate document it would be easier to make it clear that it is
>> describing the protocol between the configuration and the GUIs and not
>> get lost in the complexity of the management interface itself.
>
> Below is a first draft of documentation for all of the "echo" commands
> sent from OpenVPN via the management interface (typically, to a GUI).
>
> I think it's important to include info about how the each of the
> common open GUIs interpret the commands in this document, so those who
> want to use --echo will have a single place to look.
>
> I'm doing this inline in this email, not as a patch for several
> reasons: because it's easier to read that way, because I'd like to get
> it at least close to acceptance before proposing it as a patch, and
> because I'm not really proficient with OpenVPN's patching process and
> there will probably be several versions of the patch. (If someone else
> wants to do this as a patch from right now, I'm happy to have them
> take it over.)
>
> The section on quoting should be examined carefully -- I didn't test
> any of that.
>
> And I don't know which commands will be implemented on Android so I
> left that as "??????".
>
> Best regards,
>
> Jon
>
>
> ****************************************************
> *** New document starts after the next line ***
> ****************************************************
> Management Interface "echo" protocol
>
> ================================================================================
> THIS IS A PRELIMINARY VERSION OF THIS DOCUMENT. ALL INFORMATION IN IT
> IS SUBJECT TO CHANGE.
> ================================================================================
>
>
>     CONTENTS
>         THE OPENVPN --ECHO OPTION
>         ENVIRONMENT COMMAND
>         MESSSAGE COMMANDS
>         PASSWORD COMMANDS
>         QUOTING
>         COMMMAND DETAILS
>
>
> =========================
> THE OPENVPN --ECHO OPTION
> =========================
>
> The OpenVPN --echo option causes commands to be sent out through the
> management interface, typically to a Graphic User Interface (GUI) such
> as "OpenVPN for Android", "Tunnelblick" (for macOS), or "Windows
> OpenVPN GUI". It can be included in a configuration file or on a
> command line, or can be pushed from the server.
>
> This document describes the commands that can be sent and how they are
> interpreted by various GUIs.
>
>  * OpenVPN does not process the commands in an --echo option; it only
> sends them out through the management interface.
>
>  * "echo" commands are processed by the GUI if, as, when, and in the
> order they are received. If no GUI is present the processing of
> commands may be delayed, the commands may never be processed, or only
> some commands may be processed. (That can happen if OpenVPN discards
> commands because its buffer for the commands fills up.)
>
>  * There is no mechanism for the GUI to acknowledge the receipt,
> success, or failure of a command.
>
>  * "echo" commands are stored by OpenVPN (within limits, see the next
> point) and sent only when the GUI requests them through the management
> interface. "echo" commands in the configuration file or the command
> line are typically requested and processed at the start of a
> connection attempt. "echo" commands that are pushed by the server are
> also typically asked for at the start of a connection attempt but can
> be sent at any time. They are processed in the middle of a connection
> attempt or after a connection is established, as the "push" options
> are received by the client from the server.

This may require some clarification as what you are describing is the
result of "echo all" issued by the management client (GUI), but one
would also use "echo on" for real-time echo notification once
the mgmt interface is connected.

It may be useful to explain "echo on" "echo all" etc as it appears in
the  management-notes.txt

>
>   * OpenVPN's storage for echo commands is limited in size, so a large
> number of commands or commands with long messages may require that
> some commands be removed from the storage. If that happens, some of
> the commands may not be sent through the management interface when a
> GUI does connect to it or asks for the "echo" commands.
>
>  * On SIGUSR1 and SIGHUP connection restarts, "echo" commands that
> were sent through the management interface and have been saved by
> OpenVPN are sent again and will be re-processed by the GUI.

This is implementation dependent. It is possible for a GUI to restart
an existing connection without issuing "echo all" and only use "echo
on". In that case only newer echo command will get delivered. I think
these details could be skipped here and we just document "echo on" and
"echo all" or refer to management-notes.txt

> (The
> message commands include a mechanism for muting (skipping) duplicate
> messages, see MESSAGE COMMANDS, below.)
>
>  * OpenVPN limits the number of separate arguments in each line of a
> configuration file. Arguments may be quoted to work around this
> limitation, see QUOTING, below.
>
>  * OpenVPN limits the size of each "echo" command sent over the
> management interface to 255 bytes, including overhead characters. To
> allow messages of arbitrary length, several message commands can be
> concatenated together before being displayed to the user, see MESSAGE
> COMMANDS, below.
>
>  * There no indication to the GUI of the source of the command
> (configuration file, command line option, or pushed from a server).

There is some commented-out support for this in the sources. It may be
useful to get this revived. Essentially a flag added based on the
source of echo is pulled or local.

> It
> might be possible for the GUI to deduce that a command was pushed from
> a server because of timing or other management interface interactions.
>
>
> ===================
> ENVIRONMENT COMMAND
> ===================
>
> Typically, a GUI allows users to specify shell commands (typically
> scripts) to run at certain points in the connection/disconnection
> process, in addition to those provided by OpenVPN options such as
> "--up" and "--down".
>
> The "setenv" command can be used to set environment variables that are
> available to the scripts run by the GUI. Each "setenv" command
> specifies a value for one environment variable that is available to
> the scripts that the GUI runs.
>
> This is similar to Openvpn's "--setenv" option, which specifies an
> additional environment variable that is included in the environment
> variables that are available to the scripts that OpenVPN runs.
>
>
> =================
> MESSSAGE COMMANDS
> =================
>
> Four commands can be used to display a message to the user from the
> OpenVPN configuration or server:
>
>     msg
>     msg-n
>     msg-window
>     msg-notify
>
> "msg" and "msg-n" commands are concatenated to construct a message.
> When a "msg-window"or "msg-notify" command is received the message is
> displayed to the user.
>
> Identical messages (same title, text, and destination) received during
> one connection may be ignored or muted. Some GUIs may only show the
> first message for a connection, or the first message shown in a window
> and the first message shown as a notification.
>
>
> =================
> PASSWORD COMMANDS
> =================
>
> Three commands can be used to control the GUI's storage of usernames,
> passwords, and private keys:
>
>     disable-save-passwords
>     forget-passwords
>     save-passwords
>
>
> =======
> QUOTING
> =======
>
>  * In a configuration file, the rest of the line is parsed into
> separate arguments  and then 'echo' and the arguments are passed, each
> separated by a single space, through the management interface. For
> example:
>
>     echo     argument1 argument2
>     echo    "     argument1      argument2"
>
> will be sent through the management interface as
>
>     echo argument1 argument2
>     echo      argument1      argument2

Its actually passed as
   >ECHO:timestamp,argument1 argument2
etc. as explained in management-notes.txt.

>
>  * In a command line option, the single argument following "--echo" is
> parsed similarly, so
>
>     --echo   "argument1     argument2"
>     --echo    "'    argument1     argument2'"
>
> will be sent through the management interface as
>
>     echo argument1 argument2
>     echo     argument1     argument2

Same here: >ECHO:....


>
>  * In a "push" option in a server configuration file, the single
> option following "push" is parsed similarly, so
>
>     push "echo argument1 argument2 argument3   argument4"
>     push echo "'    argument1 argument2 argument3   argument4'"
>
> will be sent through the management interface as
>
>     echo argument1 argument2 argument3 argument4
>     echo     argument1 argument2 argument3   argument4

and here.

>
>
> ================
> COMMMAND DETAILS
> ================
>
>
> COMMAND -- disable-save-passwords
> ---------------------------------
>
> Syntax: disable-save-passwords
>
> The GUI is instructed to not allow the user to save passwords or
> private keys for the configuration. The user is still allowed to save
> usernames. Any passwords or private keys that have been saved will be
> forgotten.
>
> This command will be effective at startup only if present in the
> configuration file or as a command line option. If pushed from the
> server, saving passwords will be disabled in password prompts only
> after the initial prompt has been shown to the user.
>
>     Android: ??????
>
>     Tunnelblick: Planned. This command will disable saving of
> passwords or private keys and forget any saved usernames, passwords,
> or private keys regardless of the normal (non-forced) global or
> per-configuration settings. A computer administrator can "force" this
> setting, overriding this command.
>
>     Windows OpenVPN GUI: Planned. This command will disable saving of
> passwords or private keys and forget any saved usernames, passwords,
> or private keys regardless of any global settings.
>
>
> COMMAND -- forget-passwords
> ---------------------------
>
> Syntax: forget-passwords
>
> The GUI is instructed to forget any usernames, passwords, and private
> keys it has saved for the configuration. Useful when pushed from the
> server so that it is processed after authentication.
>
>     Android: ??????
>
>     Tunnelblick: Planned.
>
>     Windows OpenVPN GUI: Planned.

Correction: supported on WIndows since release 2.4.1 (GUI version 11.5.0)

>
>
> COMMAND -- msg
> --------------
>
> Syntax: msg text
>
> The text is appended to any previous text from "msg" or "msg-n"
> commands, and a newline is appended after that.
>
> A trailing newline will be removed from the completed message before
> it is displayed to the user.

Although this is based on our past discussion, I have come to realize
that this could be left as implementation defined. On Windows,
notification  framework automatically ignores trailing blank lines.
For msg-window too I'm leaning towards ignoring trailing blank lines
in the Windows-GUI implementation.

>
> The text may include any UTF-8 character except a comma (","), CR
> (0x0D), LF (0x0A), or NUL (0x00).

There could be some issues with # and semicolon unless quoted as the
config file uses them as comment characters. I've not tested this.

>
> The text may not contain percent ("%") except in "percent encoding"
> sequences. To display a percent sign, use %25.
>
> The text may not contain commas (",") because of constraints imposed
> by OpenVPN. Commas should be encoded using "percent encoding" (URL
> encoding): a '%' character followed by two hexadecimal digits, the
> high- and then low-nibble of the ASCII code for the character to be
> shown. Examples: a comma is encoded as %2C or %2c; a percent sign is
> encoded as %25.
>
> The insertion of line endings (CR, LF) in the text is discouraged
> because it is OS dependent.

Should we instead have that LF will be replaced by OS dependent line
ending while combinations like 0x0D0x0A (CFLF) is discouraged?

Also support some kind of urls in messages? That is
http://example.com/ embedded in the message will be displayed as a
clickable link. Or leave it as an implementation
detail? If we support this it may be useful to specify that links with
embedded spaces be enclosed in <> for easy parsing: otherwise
url-encoding within links and outside links will need to be processed
differently.

> Instead, use the "msg" command, which
> appends a line ending appropriate for the OS on which the GUI is
> running.
>
>     Android: ??????
>
>     Tunnelblick: Planned.
>
>     Windows OpenVPN GUI: Planned.
>
> COMMAND -- msg-n
> ----------------
>
> Syntax: msg-n text
>
> The text is appended to any previous text from "msg"" or "msg-n""
> commands. (Like "msg" except that no newline is appended.)
>
> See "COMMAND -- msg" for details about "text".
>
>     Android: ??????
>
>     Tunnelblick: Planned.
>
>     Windows OpenVPN GUI: Planned.
>
> COMMAND -- msg-notify
> ---------------------
>
> Syntax: msg-notify title
>
> The text from previous "msg" and/or "msg-n" commands is displayed to
> the user as a notification with title "title" and the previous text is
> forgotten.
>
>     Android: ??????
>
>     Tunnelblick: Planned.
>
>     Windows OpenVPN GUI: Planned.

The max length that will correctly display as a notification message
is OS dependent.

>
> COMMAND -- msg-window title
> ---------------------------
>
> Syntax: msg-window title
>
> The text from previous "msg" and/or "msg-n" commands is displayed to
> the user in a non-modal popup window with title "title" and the
> previous text is forgotten..
>
>     Android: ??????
>
>     Tunnelblick: Planned.
>
>     Windows OpenVPN GUI: Planned.

Should we specify a max length of title? Or leave it as implementation defined?

>
>
> COMMAND -- save-passwords
> -------------------------
>
> Syntax: save-passwords
>
> The GUI is instructed to allow the user to save usernames, passwords
> and private keys for the configuration.
>
> This command will be effective at startup only if present in the
> configuration file or as a command line option. If pushed from the
> server, saving passwords will be allowed in password prompts only
> after the initial prompt has been shown to the user.
>
> This command typically has the effect of presenting the password
> dialogs to the user with a "save password" checkbox checked. The user
> may still uncheck it during the dialog.
>
>     Android: ??????
>
>     Tunnelblick: Planned. Tunnelblick ignores this command. Usernames,
> passwords, and private keys may be saved by default, and this command
> will not override the separate Tunnelblick global or per-configuration
> settings used to disable saving them.
>
>     Windows OpenVPN GUI: Planned. OpenVPN GUI always saves the
> username (although that is subject to change as of 2017-11-30). This
> command will override a global setting that disables saving passwords
> and allow passwords to be saved.

Correction: Supported since release 2.4.1 (GUI version 11.5.0). And
delete the comment about username etc. Although the current
implementation allows this to override the global setting of
disable-save-passwords, that is a "bug" and will be fixed. So not to
be stated in these docs.

>
>
> COMMAND -- setenv
> -----------------
>
> Syntax: setenv name value
>
> Sets an environment variable that will be available to the scripts run
> by the GUI.
>
> This will set environment variable "OPENVPN_name" to value "value" for
> the scripts run by the GUI. "name" is changed to "OPENVPN_name" to
> prevent overwriting sensitive variables such as PATH. Variables are
> set in the order received, with later values replacing earlier ones
> for the same "name".
>
> Names may include only alphanumeric characters and underscores. A
> "setenv" command with an invalid name will be ignored.
>
>     Android: ??????
>
>     Tunnelblick: Planned.
>
>     Windows OpenVPN GUI: Planned. When the variables set by "setenv"
> are merged with those for the process environment, the variables set
> by "setenv" are listed first, but any duplicates in the process
> environment are not removed. This means that any variables with the
> same name will have the value of the variable in the process
> environment.

Correction: variable of same name will have the value specified by
setenv, not the one in process env. At least that is my understanding
of what will happen when the two are merged with the setenv values
appearing first.

What to do if value is missing. I think OpenVPN currently sets name=""
if value is missing in the --setenv option to the daemon. Use the same
approach here or treat missing value as a directive to delete the name
from env?

Selva

