MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Sun, 27 Nov 2016 17:28:23 -0500
Message-ID: <CAKuzo_ihmknuQQfJEupQ0b4CvTtoHMb6RqcH3jw0Zh_J2G+KTQ@...278...>
Content-Type: multipart/alternative; boundary=001a113a3162b795d705424fe000
Subject: [Openvpn-devel] pkcs11 token prompts in openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113a3162b795d705424fe000
Content-Type: text/plain; charset=UTF-8

NB: Appearance to the contrary, this is not Windows specific, so please
read on :)

Hi,

In response to the GUI patch that adds support for pkcs11 token prompts
(see Trac 740: https://community.openvpn.net/openvpn/ticket/740), got a
detailed test report copied below.

Essentially, all god except if/when the token is physically removed during
the dialog. That results in repeated prompts for re-inserting the token
even if the user clicks cancel.

It appears this mis-behaviour is seen in command line usageas well so its
from openvpn core itself. Any idea how this could be fixed in openvpn or
pkcs11-helper library if that is the culprit?

As a short-term work around we could have the GUI stop the openvpn process
on user pressing cancel in response to token insertion request. I would
like to avoid that if possible -- now we set --auth-retry to none and
expect openvpn not to retry private key password. That doesn't appear to
work in this case.

Selva

Test report by @bjoernv (Trac 740 comment 16)

I tested the latest PR again with a Yubikey 4 and OpenSC drivers. In the
following situations the new code works right:

   1. Yubikey 4 insert -> start account in OpenVPN GUI -> "Input
   Password/PIN for Token 'PIV_II (PIV Card holder pin)" dialog -> enter
   correct PIN -> OK
   2. Yubikey 4 insert -> start account in OpenVPN GUI -> "Input
   Password/PIN for Token 'PIV_II (PIV Card holder pin)" dialog -> Cancel ->
   Stop -> OK
   3. start account in OpenVPN GUI -> "Please insert PIV_II (PIV Card
   Holder pin) token" dialog -> Cancel -> Stop -> OK

In the following more exotic situation the program still runs in an endless
loop:

   1. Yubikey 4 insert -> start account in OpenVPN GUI -> "Input
   Password/PIN for Token 'PIV_II (PIV Card holder pin)" dialog -> remove
   Yubikey 4 -> enter correct or incorrect PIN -> "Please insert PIV_II (PIV
   Card Holder pin) token" dialog -> last dialog loops regardless if the user
   chooses OK or Cancel. The user still can press "Disconnect" on the log
   windows, if he is fast enough to close the session.

--001a113a3162b795d705424fe000
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail-comment gmail-searchable">
      <p>NB: Appearance to the contrary, this is not Windows specific, so p=
lease read on :) <br></p><p>Hi,<br></p><p>In response to the GUI patch that=
 adds support for pkcs11 token prompts (see Trac 740: <a href=3D"https://co=
mmunity.openvpn.net/openvpn/ticket/740">https://community.openvpn.net/openv=
pn/ticket/740</a>), got a detailed test report copied below.</p><p>Essentia=
lly, all god except if/when the token is physically removed during the dial=
og. That results in repeated prompts for re-inserting the token even if the=
 user clicks cancel.</p><p>It appears this mis-behaviour is seen in command=
 line usageas well so its from openvpn core itself. Any idea how this could=
 be fixed in openvpn or pkcs11-helper library if that is the culprit?</p><p=
>As a short-term work around we could have the GUI stop the openvpn process=
 on user pressing cancel in response to token insertion request. I would li=
ke to avoid that if possible -- now we set --auth-retry to none and expect =
openvpn not to retry private key password. That doesn&#39;t appear to work =
in this case. <br></p><p>Selva</p><p>Test report by @bjoernv (Trac 740 comm=
ent 16)<br></p><p>
I tested the latest PR again with a Yubikey 4 and OpenSC drivers. In the fo=
llowing situations the new code works right:<br>
</p>
<ol><li>Yubikey 4 insert -&gt; start account in OpenVPN GUI -&gt; &quot;Inp=
ut
 Password/PIN for Token &#39;PIV_II (PIV Card holder pin)&quot; dialog -&gt=
;=20
enter correct PIN -&gt; OK
</li><li>Yubikey 4 insert -&gt; start account in OpenVPN GUI -&gt;=20
&quot;Input Password/PIN for Token &#39;PIV_II (PIV Card holder pin)&quot; =
dialog=20
-&gt; Cancel -&gt; Stop -&gt; OK
</li><li>start account in OpenVPN GUI -&gt; &quot;Please insert PIV_II (PIV=
 Card Holder pin) token&quot; dialog -&gt; Cancel -&gt; Stop -&gt; OK
</li></ol><p>
In the following more exotic situation the program still runs in an endless=
 loop:<br>
</p>
<ol start=3D"4"><li>Yubikey 4 insert -&gt; start account in OpenVPN GUI=20
-&gt; &quot;Input Password/PIN for Token &#39;PIV_II (PIV Card holder pin)&=
quot;=20
dialog -&gt; remove Yubikey 4 -&gt; enter correct or incorrect PIN -&gt;
 &quot;Please insert PIV_II (PIV Card Holder pin) token&quot; dialog -&gt; =
last=20
dialog loops regardless if the user chooses OK or Cancel. The user still
 can press &quot;Disconnect&quot; on the log windows, if he is fast enough =
to=20
close the session.
</li></ol>
    </div></div>

--001a113a3162b795d705424fe000--

