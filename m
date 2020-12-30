MIME-Version: 1.0
References: <CAKuzo_gMh+ZJ0YovjkUdyHzDO8cLsM_2Djsk_Hrx6N3AZMPw7w@...278...>
 <20201225192621.28592-1-gert@...1296...>
In-Reply-To: <20201225192621.28592-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 30 Dec 2020 12:40:55 -0500
Message-ID: <CAKuzo_hQjPJ0HAMRtjnqxD-UVsiSK4-S3rtn0hq_DRjAx1tuCg@...278...>
Content-Type: multipart/alternative; boundary="0000000000005ddd9c05b7b203f3"
Subject: Re: [Openvpn-devel] [PATCH] Document common uses of 'echo'
 directive, re-enable logging for 'echo'.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000005ddd9c05b7b203f3
Content-Type: text/plain; charset="UTF-8"

Hi,

Some small corrections to the proposed doc below

On Fri, Dec 25, 2020 at 2:28 PM Gert Doering <gert@...1296...> wrote:

> The 'echo' command can be used to signal information to an OpenVPN
> GUI driving the openvpn core via management interface.  Which commands
> exists and their syntax has so far been mostly undocumented.
>
> Condense the long and good discussion between Selva Nair and
> Jonathan K. Bullard into doc/gui-notes.txt (initial draft from
> Jonathan, comments from Selva and Arne), with a pointer added
> to doc/management-notes.txt.
>
> See:
>
>
> https://sourceforge.net/p/openvpn/mailman/openvpn-users/thread/CAEsd45T%2Bd6FUJ9Po0KHwtHjfuL9Q2D-poG8yFtY45Qyh%2BtHjkg%40mail.gmail.com/#msg36136236
>
> and
>
>
> https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA%40mail.gmail.com/#msg36141193
>
> for the details.
>
> Re-enable logging of 'echo' statements, but only for the particular
> class of messages starting with 'echo msg...'.
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  doc/Makefile.am          |   2 +-
>  doc/gui-notes.txt        | 363 +++++++++++++++++++++++++++++++++++++++
>  doc/management-notes.txt |  10 ++
>  src/openvpn/options.c    |  15 +-
>  4 files changed, 382 insertions(+), 8 deletions(-)
>  create mode 100644 doc/gui-notes.txt
>
> diff --git a/doc/Makefile.am b/doc/Makefile.am
> index df2f54a3..e411f5f9 100644
> --- a/doc/Makefile.am
> +++ b/doc/Makefile.am
> @@ -15,7 +15,7 @@ MAINTAINERCLEANFILES = \
>  SUBDIRS = doxygen
>
>  dist_doc_DATA = \
> -       management-notes.txt
> +       management-notes.txt gui-notes.txt
>
>  dist_noinst_DATA = \
>         README.plugins interactive-service-notes.rst \
> diff --git a/doc/gui-notes.txt b/doc/gui-notes.txt
> new file mode 100644
> index 00000000..9715e8f6
> --- /dev/null
> +++ b/doc/gui-notes.txt
> @@ -0,0 +1,363 @@
> +Management Interface "echo" protocol
> +
>
> +================================================================================
> +THIS IS A PRELIMINARY VERSION OF THIS DOCUMENT. ALL INFORMATION IN IT
> +IS SUBJECT TO CHANGE.
>
> +================================================================================
> +
> +
> +    CONTENTS
> +        THE OPENVPN --ECHO OPTION
> +        ENVIRONMENT COMMAND
> +        MESSSAGE COMMANDS
> +        PASSWORD COMMANDS
> +        QUOTING
> +        COMMMAND DETAILS
> +
> +
>
>
...snipped..


> +=======
> +QUOTING
> +=======
> +
> + * In a configuration file, the rest of the line is parsed into
> +separate arguments  and then 'echo' and the arguments are passed, each
> +separated by a single space, through the management interface. For
> +example:
> +
> +    echo     argument1 argument2
> +    echo    "     argument1      argument2"
> +
> +will be sent through the management interface as
> +
> +    >ECHO:timestamp,argument1,argument2
> +    >ECHO:timestamp,     argument1,     argument2
>

Should be
 >ECHO:timestamp,argument1 argument2
 >ECHO:timestamp,     argument1     argument2

(Only a comma after timestamp, no commas added between words)

+
> + * In a command line option, the single argument following "--echo" is
> +parsed similarly, so
> +
> +    --echo   "argument1     argument2"
>

Remove quotes to match with example above


> +    --echo    "'    argument1     argument2'"
>

Extra single quotes above are probably not intended.


> +
> +will be sent through the management interface as
> +
> +    >ECHO:timestamp,argument1,argument2


replace comma after argument1 by space


> +    >ECHO:timestamp,     argument1,     argument2


remove comma after argument1


> +
> + * In a "push" option in a server configuration file, the single
> +option following "push" is parsed similarly, so
> +
> +    push "echo argument1 argument2 argument3   argument4"
> +    push echo "'    argument1 argument2 argument3   argument4'"
>

The opening quote should move to before echo:

 push "echo '    argument1 argument2 argument3   argument4'"


> +will be sent through the management interface as
> +
> +    >ECHO:timestamp,argument1,argument2,argument3 argument4
>

replace commas after first one by space


> +    >ECHO:timestamp,     argument1,argument2 argument3   argument4
>

replace comma after argument1 by space


.. snipped...


> +COMMAND -- msg
> +--------------
> +
> +Syntax: msg text
> +
> +The text is appended to any previous text from "msg" or "msg-n"
> +commands, and a newline is appended after that.
> +
> +A trailing newline will be removed from the completed message before
> +it is displayed to the user.
> +
> +The text may include any UTF-8 character except a comma (","), CR
> +(0x0D), LF (0x0A), or NUL (0x00).

+
> +The text may not contain percent ("%") except in "percent encoding"
> +sequences. To display a percent sign, use %25.
> +
> +The text may not contain commas (",") because of constraints imposed
> +by OpenVPN. Commas should be encoded using "percent encoding" (URL
> +encoding): a '%' character followed by two hexadecimal digits, the
> +high- and then low-nibble of the ASCII code for the character to be
> +shown. Examples: a comma is encoded as %2C or %2c; a percent sign is
> +encoded as %25.


Here we could add:
Text containing comment characters # and ; must be enclosed in quotes to
survive after option parsing by openvpn.


> +
> +The insertion of line endings (CR, LF) in the text is discouraged
> +because it is OS dependent. Instead, use the "msg" command, which
> +appends a line ending appropriate for the OS on which the GUI is
> +running.
> +
> +    Android: ??????
> +
> +    Tunnelblick: Planned.
> +
> +    Windows OpenVPN GUI: Planned.
> +
> +COMMAND -- msg-n
> +----------------
> +
> +Syntax: msg-n text
> +
> +The text is appended to any previous text from "msg"" or "msg-n""
> +commands. (Like "msg" except that no newline is appended.)
> +
> +See "COMMAND -- msg" for details about "text".
> +
> +    Android: ??????
> +
> +    Tunnelblick: Planned.
> +
> +    Windows OpenVPN GUI: Planned.
> +
> +COMMAND -- msg-notify
> +---------------------
> +
> +Syntax: msg-notify title
> +
> +The text from previous "msg" and/or "msg-n" commands is displayed to
> +the user as a notification with title "title" and the previous text is
> +forgotten.
> +
> +    Android: ??????
> +
> +    Tunnelblick: Planned.
> +
> +    Windows OpenVPN GUI: Planned.
> +
> +Note: The max length that will correctly display as a notification
> +message is OS dependent.
> +
> +
> +COMMAND -- msg-window title
> +---------------------------
> +
> +Syntax: msg-window title
> +
> +The text from previous "msg" and/or "msg-n" commands is displayed to
> +the user in a non-modal popup window with title "title" and the
> +previous text is forgotten..
>

How the title is displayed is better left to the implementation. Could be
set as the
window title or as a differently formatted text as the heading of the
message, for example. The latter approach is taken in the proposed OpenVPN
GUI implementation.

+
> +    Android: ??????
> +
> +    Tunnelblick: Planned.
> +
> +    Windows OpenVPN GUI: Planned.
> +
> +
> +COMMAND -- save-passwords
> +-------------------------
> +
> +Syntax: save-passwords
> +
> +The GUI is instructed to allow the user to save usernames, passwords
> +and private keys for the configuration.
> +
> +This command will be effective at startup only if present in the
> +configuration file or as a command line option. If pushed from the
> +server, saving passwords will be allowed in password prompts only
> +after the initial prompt has been shown to the user.
> +
> +This command typically has the effect of presenting the password
> +dialogs to the user with a "save password" checkbox checked. The user
> +may still uncheck it during the dialog.
> +
> +    Android: ??????
> +
> +    Tunnelblick: Planned. Tunnelblick ignores this command. Usernames,
> +passwords, and private keys may be saved by default, and this command
> +will not override the separate Tunnelblick global or per-configuration
> +settings used to disable saving them.
> +
> +    Windows OpenVPN GUI: Supported since release 2.4.1 (GUI version
> 11.5.0)
> +
> +
> +COMMAND -- setenv
> +-----------------
> +
> +Syntax: setenv name value
> +
> +Sets an environment variable that will be available to the scripts run
> +by the GUI.
> +
> +This will set environment variable "OPENVPN_name" to value "value" for
> +the scripts run by the GUI. "name" is changed to "OPENVPN_name" to
> +prevent overwriting sensitive variables such as PATH. Variables are
> +set in the order received, with later values replacing earlier ones
> +for the same "name".
> +
> +Names may include only alphanumeric characters and underscores. A
> +"setenv" command with an invalid name will be ignored.
> +
> +    Android: ??????
> +
> +    Tunnelblick: Planned.
> +
> +    Windows OpenVPN GUI: Planned. When the variables set by "setenv"
> +are merged with those for the process environment, the variables set
> +by "setenv" are listed first, but any duplicates in the process
> +environment are not removed. This means that any variables with the
> +same name will have the value of the variable in the process
> +environment.
>

The GUI supports this since v11.12.0 (release 2.4.7)
Also, the description above is not correct. In case of duplicate names the
one in the  setenv list is chosen. The merged list is sorted as required on
Windows.

The rest looks good to me.

Selva

--0000000000005ddd9c05b7b203f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>Some small correct=
ions to the proposed doc below</div><div><br></div></div><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 25, 2020 at 2:28=
 PM Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">g=
ert@...1296...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">The &#39;echo&#39; command can be used to signal information =
to an OpenVPN<br>
GUI driving the openvpn core via management interface.=C2=A0 Which commands=
<br>
exists and their syntax has so far been mostly undocumented.<br>
<br>
Condense the long and good discussion between Selva Nair and<br>
Jonathan K. Bullard into doc/gui-notes.txt (initial draft from<br>
Jonathan, comments from Selva and Arne), with a pointer added<br>
to doc/management-notes.txt.<br>
<br>
See:<br>
<br>
<a href=3D"https://sourceforge.net/p/openvpn/mailman/openvpn-users/thread/C=
AEsd45T%2Bd6FUJ9Po0KHwtHjfuL9Q2D-poG8yFtY45Qyh%2BtHjkg%40mail.gmail.com/#ms=
g36136236" rel=3D"noreferrer" target=3D"_blank">https://sourceforge.net/p/o=
penvpn/mailman/openvpn-users/thread/CAEsd45T%2Bd6FUJ9Po0KHwtHjfuL9Q2D-poG8y=
FtY45Qyh%2BtHjkg%40mail.gmail.com/#msg36136236</a><br>
<br>
and<br>
<br>
<a href=3D"https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/C=
AKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA%40mail.gmail.com/#msg361=
41193" rel=3D"noreferrer" target=3D"_blank">https://sourceforge.net/p/openv=
pn/mailman/openvpn-devel/thread/CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHic=
Y8P2WRqA%40mail.gmail.com/#msg36141193</a><br>
<br>
for the details.<br>
<br>
Re-enable logging of &#39;echo&#39; statements, but only for the particular=
<br>
class of messages starting with &#39;echo msg...&#39;.<br>
<br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt;<br>
---<br>
=C2=A0doc/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<=
br>
=C2=A0doc/gui-notes.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 363 ++++++++++++++++++=
+++++++++++++++++++++<br>
=C2=A0doc/management-notes.txt |=C2=A0 10 ++<br>
=C2=A0src/openvpn/options.c=C2=A0 =C2=A0 |=C2=A0 15 +-<br>
=C2=A04 files changed, 382 insertions(+), 8 deletions(-)<br>
=C2=A0create mode 100644 doc/gui-notes.txt<br>
<br>
diff --git a/doc/Makefile.am b/doc/Makefile.am<br>
index df2f54a3..e411f5f9 100644<br>
--- a/doc/Makefile.am<br>
+++ b/doc/Makefile.am<br>
@@ -15,7 +15,7 @@ MAINTAINERCLEANFILES =3D \<br>
=C2=A0SUBDIRS =3D doxygen<br>
<br>
=C2=A0dist_doc_DATA =3D \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0management-notes.txt<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0management-notes.txt gui-notes.txt<br>
<br>
=C2=A0dist_noinst_DATA =3D \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 README.plugins interactive-service-notes.rst \<=
br>
diff --git a/doc/gui-notes.txt b/doc/gui-notes.txt<br>
new file mode 100644<br>
index 00000000..9715e8f6<br>
--- /dev/null<br>
+++ b/doc/gui-notes.txt<br>
@@ -0,0 +1,363 @@<br>
+Management Interface &quot;echo&quot; protocol<br>
+<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>
+THIS IS A PRELIMINARY VERSION OF THIS DOCUMENT. ALL INFORMATION IN IT<br>
+IS SUBJECT TO CHANGE.<br>
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>
+<br>
+<br>
+=C2=A0 =C2=A0 CONTENTS<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 THE OPENVPN --ECHO OPTION<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ENVIRONMENT COMMAND<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 MESSSAGE COMMANDS<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 PASSWORD COMMANDS<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QUOTING<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 COMMMAND DETAILS<br>
+<br>
+<br><br></blockquote><div><br></div><div>...snipped..</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
+=3D=3D=3D=3D=3D=3D=3D<br>
+QUOTING<br>
+=3D=3D=3D=3D=3D=3D=3D<br>
+<br>
+ * In a configuration file, the rest of the line is parsed into<br>
+separate arguments=C2=A0 and then &#39;echo&#39; and the arguments are pas=
sed, each<br>
+separated by a single space, through the management interface. For<br>
+example:<br>
+<br>
+=C2=A0 =C2=A0 echo=C2=A0 =C2=A0 =C2=A0argument1 argument2<br>
+=C2=A0 =C2=A0 echo=C2=A0 =C2=A0 &quot;=C2=A0 =C2=A0 =C2=A0argument1=C2=A0 =
=C2=A0 =C2=A0 argument2&quot;<br>
+<br>
+will be sent through the management interface as<br>
+<br>
+=C2=A0 =C2=A0 &gt;ECHO:timestamp,argument1,argument2<br>
+=C2=A0 =C2=A0 &gt;ECHO:timestamp,=C2=A0 =C2=A0 =C2=A0argument1,=C2=A0 =C2=
=A0 =C2=A0argument2<br></blockquote><div><br></div><div>Should be</div><div=
>=C2=A0&gt;ECHO:timestamp,argument1 argument2</div><div>=C2=A0&gt;ECHO:time=
stamp,=C2=A0 =C2=A0 =C2=A0argument1=C2=A0 =C2=A0 =C2=A0argument2

</div><div><br></div><div>(Only a comma after timestamp, no commas=C2=A0add=
ed between words)</div><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
+<br>
+ * In a command line option, the single argument following &quot;--echo&qu=
ot; is<br>
+parsed similarly, so<br>
+<br>
+=C2=A0 =C2=A0 --echo=C2=A0 =C2=A0&quot;argument1=C2=A0 =C2=A0 =C2=A0argume=
nt2&quot;<br></blockquote><div><br></div><div>Remove quotes to match with e=
xample above</div><div>=C2=A0=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
+=C2=A0 =C2=A0 --echo=C2=A0 =C2=A0 &quot;&#39;=C2=A0 =C2=A0 argument1=C2=A0=
 =C2=A0 =C2=A0argument2&#39;&quot;<br></blockquote><div><br></div><div>Extr=
a single quotes above are probably not intended.</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+will be sent through the management interface as<br>
+<br>
+=C2=A0 =C2=A0 &gt;ECHO:timestamp,argument1,argument2=C2=A0</blockquote><di=
v><br></div><div>replace comma after argument1 by space</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 &gt;ECHO:timestamp,=C2=A0 =C2=A0 =C2=A0argument1,=C2=A0 =C2=
=A0 =C2=A0argument2=C2=A0</blockquote><div><br></div><div>remove comma afte=
r argument1</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+<br>
+ * In a &quot;push&quot; option in a server configuration file, the single=
<br>
+option following &quot;push&quot; is parsed similarly, so<br>
+<br>
+=C2=A0 =C2=A0 push &quot;echo argument1 argument2 argument3=C2=A0 =C2=A0ar=
gument4&quot;<br>
+=C2=A0 =C2=A0 push echo &quot;&#39;=C2=A0 =C2=A0 argument1 argument2 argum=
ent3=C2=A0 =C2=A0argument4&#39;&quot;<br></blockquote><div><br></div><div>T=
he opening quote should move to before echo:</div><div>=C2=A0</div><div>=C2=
=A0push &quot;echo &#39;=C2=A0 =C2=A0 argument1 argument2 argument3=C2=A0 =
=C2=A0argument4&#39;&quot;</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
+will be sent through the management interface as<br>
+<br>
+=C2=A0 =C2=A0 &gt;ECHO:timestamp,argument1,argument2,argument3 argument4<b=
r></blockquote><div><br></div><div>replace commas after first one by space<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 &gt;ECHO:timestamp,=C2=A0 =C2=A0 =C2=A0argument1,argument2 a=
rgument3=C2=A0 =C2=A0argument4<br></blockquote><div><br></div><div>replace =
comma after argument1 by space</div><div><br></div><div>=C2=A0</div><div>..=
 snipped...</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+COMMAND -- msg<br>
+--------------<br>
+<br>
+Syntax: msg text<br>
+<br>
+The text is appended to any previous text from &quot;msg&quot; or &quot;ms=
g-n&quot;<br>
+commands, and a newline is appended after that.<br>
+<br>
+A trailing newline will be removed from the completed message before<br>
+it is displayed to the user.<br>
+<br>
+The text may include any UTF-8 character except a comma (&quot;,&quot;), C=
R<br>
+(0x0D), LF (0x0A), or NUL (0x00).</blockquote><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
+<br>
+The text may not contain percent (&quot;%&quot;) except in &quot;percent e=
ncoding&quot;<br>
+sequences. To display a percent sign, use %25.<br>
+<br>
+The text may not contain commas (&quot;,&quot;) because of constraints imp=
osed<br>
+by OpenVPN. Commas should be encoded using &quot;percent encoding&quot; (U=
RL<br>
+encoding): a &#39;%&#39; character followed by two hexadecimal digits, the=
<br>
+high- and then low-nibble of the ASCII code for the character to be<br>
+shown. Examples: a comma is encoded as %2C or %2c; a percent sign is<br>
+encoded as %25.</blockquote><div><br></div><div>Here we could add:=C2=A0</=
div><div>Text containing comment characters # and ; must be enclosed in quo=
tes to survive after option parsing by openvpn.</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+The insertion of line endings (CR, LF) in the text is discouraged<br>
+because it is OS dependent. Instead, use the &quot;msg&quot; command, whic=
h<br>
+appends a line ending appropriate for the OS on which the GUI is<br>
+running.<br>
+<br>
+=C2=A0 =C2=A0 Android: ??????<br>
+<br>
+=C2=A0 =C2=A0 Tunnelblick: Planned.<br>
+<br>
+=C2=A0 =C2=A0 Windows OpenVPN GUI: Planned.<br>
+<br>
+COMMAND -- msg-n<br>
+----------------<br>
+<br>
+Syntax: msg-n text<br>
+<br>
+The text is appended to any previous text from &quot;msg&quot;&quot; or &q=
uot;msg-n&quot;&quot;<br>
+commands. (Like &quot;msg&quot; except that no newline is appended.)<br>
+<br>
+See &quot;COMMAND -- msg&quot; for details about &quot;text&quot;.<br>
+<br>
+=C2=A0 =C2=A0 Android: ??????<br>
+<br>
+=C2=A0 =C2=A0 Tunnelblick: Planned.<br>
+<br>
+=C2=A0 =C2=A0 Windows OpenVPN GUI: Planned.<br>
+<br>
+COMMAND -- msg-notify<br>
+---------------------<br>
+<br>
+Syntax: msg-notify title<br>
+<br>
+The text from previous &quot;msg&quot; and/or &quot;msg-n&quot; commands i=
s displayed to<br>
+the user as a notification with title &quot;title&quot; and the previous t=
ext is<br>
+forgotten.<br>
+<br>
+=C2=A0 =C2=A0 Android: ??????<br>
+<br>
+=C2=A0 =C2=A0 Tunnelblick: Planned.<br>
+<br>
+=C2=A0 =C2=A0 Windows OpenVPN GUI: Planned.<br>
+<br>
+Note: The max length that will correctly display as a notification<br>
+message is OS dependent.<br>
+<br>
+<br>
+COMMAND -- msg-window title<br>
+---------------------------<br>
+<br>
+Syntax: msg-window title<br>
+<br>
+The text from previous &quot;msg&quot; and/or &quot;msg-n&quot; commands i=
s displayed to<br>
+the user in a non-modal popup window with title &quot;title&quot; and the<=
br>
+previous text is forgotten..<br></blockquote><div><br></div><div>How the t=
itle is displayed is better left to the implementation. Could be set as the=
</div><div>window title or as a differently formatted text as the heading o=
f the message, for example. The latter approach is taken in the proposed Op=
enVPN GUI implementation.</div><div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 Android: ??????<br>
+<br>
+=C2=A0 =C2=A0 Tunnelblick: Planned.<br>
+<br>
+=C2=A0 =C2=A0 Windows OpenVPN GUI: Planned.<br>
+<br>
+<br>
+COMMAND -- save-passwords<br>
+-------------------------<br>
+<br>
+Syntax: save-passwords<br>
+<br>
+The GUI is instructed to allow the user to save usernames, passwords<br>
+and private keys for the configuration.<br>
+<br>
+This command will be effective at startup only if present in the<br>
+configuration file or as a command line option. If pushed from the<br>
+server, saving passwords will be allowed in password prompts only<br>
+after the initial prompt has been shown to the user.<br>
+<br>
+This command typically has the effect of presenting the password<br>
+dialogs to the user with a &quot;save password&quot; checkbox checked. The=
 user<br>
+may still uncheck it during the dialog.<br>
+<br>
+=C2=A0 =C2=A0 Android: ??????<br>
+<br>
+=C2=A0 =C2=A0 Tunnelblick: Planned. Tunnelblick ignores this command. User=
names,<br>
+passwords, and private keys may be saved by default, and this command<br>
+will not override the separate Tunnelblick global or per-configuration<br>
+settings used to disable saving them.<br>
+<br>
+=C2=A0 =C2=A0 Windows OpenVPN GUI: Supported since release 2.4.1 (GUI vers=
ion 11.5.0)<br>
+<br>
+<br>
+COMMAND -- setenv<br>
+-----------------<br>
+<br>
+Syntax: setenv name value<br>
+<br>
+Sets an environment variable that will be available to the scripts run<br>
+by the GUI.<br>
+<br>
+This will set environment variable &quot;OPENVPN_name&quot; to value &quot=
;value&quot; for<br>
+the scripts run by the GUI. &quot;name&quot; is changed to &quot;OPENVPN_n=
ame&quot; to<br>
+prevent overwriting sensitive variables such as PATH. Variables are<br>
+set in the order received, with later values replacing earlier ones<br>
+for the same &quot;name&quot;.<br>
+<br>
+Names may include only alphanumeric characters and underscores. A<br>
+&quot;setenv&quot; command with an invalid name will be ignored.<br>
+<br>
+=C2=A0 =C2=A0 Android: ??????<br>
+<br>
+=C2=A0 =C2=A0 Tunnelblick: Planned.<br>
+<br>
+=C2=A0 =C2=A0 Windows OpenVPN GUI: Planned. When the variables set by &quo=
t;setenv&quot;<br>
+are merged with those for the process environment, the variables set<br>
+by &quot;setenv&quot; are listed first, but any duplicates in the process<=
br>
+environment are not removed. This means that any variables with the<br>
+same name will have the value of the variable in the process<br>
+environment.<br></blockquote><div><br></div><div>The GUI supports this sin=
ce v11.12.0 (release 2.4.7)</div><div>Also, the description above is not co=
rrect. In case of duplicate names the one in the=C2=A0 setenv list is chose=
n. The merged list is sorted as required on Windows.</div><div><br></div><d=
iv>The rest looks good to me.</div><div><br></div><div>Selva</div></div></d=
iv>

--0000000000005ddd9c05b7b203f3--

