MIME-Version: 1.0
In-Reply-To: <CAKuzo_jU0AL9w1MZ-mCfp5_+Q=v2xhYfN1L+eKgN1ZsKtUmzLQ@...278...>
References: <54450921.30501@...515...> <54461F20.5060908@...1147...>
	<20141021091159.GY396@...1296...>
	<CAEsd45SOhJcowu27gs6Be5YShph91pUBwq4eBfhGtpCT2MXo1w@...278...>
	<20141021104308.GZ396@...1296...>
	<CAEsd45Qa34HsKZ6rwhuF5qnvBBnsFVeaJcRConfLEjXOdu+StQ@...278...>
	<CAKuzo_juo92ZC8aGjE4FN=EFnw1WMczE_noX7Aa2m+wQEXeJfQ@...278...>
	<20141021142617.GD396@...1296...>
	<CAKuzo_jU0AL9w1MZ-mCfp5_+Q=v2xhYfN1L+eKgN1ZsKtUmzLQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 21 Oct 2014 12:08:27 -0400
Message-ID: <CAKuzo_gHOM3ZJfK5Shu4XcCcuG3qPadwsbQHpNCNwFBR67N4fg@...278...>
Content-Type: multipart/alternative; boundary=089e01538bccdaf6760505f10b82
Subject: [Openvpn-devel] Fwd: New OpenVPN Windows installers (I004 and I604)
	released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--089e01538bccdaf6760505f10b82
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue, Oct 21, 2014 at 10:26 AM, Gert Doering <gert@...1296...> wrote:

> On Tue, Oct 21, 2014 at 09:55:09AM -0400, Selva Nair wrote:
>> Currently OpneVPN-MI-GUI does work without elevated privileges using
>> openvpn service and the management interface. I have a small user-base
who
>> have been happily using it this way for more than a year now. In my view
if
>> OpenVPN distribution could bundle the MI-GUI, it would be of great help.

>Well, that works, but runs OpenVPN as privileged user - so a bug in
>OpenVPN (or a config that runs scripts) could be used to attack the
>system...

Sure, the "log term" plan of having OpenVPN run as a normal user is great,
but the
current situation of every windows user needing admin privilege to run the
UI is
hard to meet in many installations.

The MI-GUI solves that problem right now as opposed to sometime in future.

(Plus, traditionally using the service will not work with username+password
input, but if MI does that via management interface, it can be done)

That's exactly what MI-GUI it does -- both certificate password and
username/password
are passed through the management interface. Locally, I have patched it to
pass the
certificate key as well although we don't normally use that option.

Selva

--089e01538bccdaf6760505f10b82
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_quote"><div dir=3D"ltr"><div cl=
ass=3D"gmail_extra"><span class=3D""><br><div class=3D"gmail_quote">On Tue,=
 Oct 21, 2014 at 10:26 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span> wrot=
e:</div></span><div class=3D"gmail_quote"><span class=3D""><div class=3D"gm=
ail_quote"><br></div><div class=3D"gmail_quote">&gt; On Tue, Oct 21, 2014 a=
t 09:55:09AM -0400, Selva Nair wrote:</div><div class=3D"gmail_quote">&gt;&=
gt; Currently OpneVPN-MI-GUI does work without elevated privileges using</d=
iv><div class=3D"gmail_quote">&gt;&gt; openvpn service and the management i=
nterface. I have a small user-base who</div><div class=3D"gmail_quote">&gt;=
&gt; have been happily using it this way for more than a year now. In my vi=
ew if</div><div class=3D"gmail_quote">&gt;&gt; OpenVPN distribution could b=
undle the MI-GUI, it would be of great help.</div><div class=3D"gmail_quote=
"><br></div><div class=3D"gmail_quote">&gt;Well, that works, but runs OpenV=
PN as privileged user - so a bug in</div><div class=3D"gmail_quote">&gt;Ope=
nVPN (or a config that runs scripts) could be used to attack the</div><div =
class=3D"gmail_quote">&gt;system...</div><div class=3D"gmail_quote"><br></d=
iv></span><div class=3D"gmail_quote">Sure, the &quot;log term&quot; plan of=
 having OpenVPN run as a normal user is great, but the=C2=A0</div><div clas=
s=3D"gmail_quote">current situation of every windows user needing admin pri=
vilege to run the UI is</div><div class=3D"gmail_quote">hard to meet in man=
y installations.=C2=A0</div><div class=3D"gmail_quote"><br></div><div class=
=3D"gmail_quote">The MI-GUI solves that problem right now as opposed to som=
etime in future.=C2=A0</div><span class=3D""><div class=3D"gmail_quote"><br=
></div><div class=3D"gmail_quote">(Plus, traditionally using the service wi=
ll not work with username+password</div><div class=3D"gmail_quote">input, b=
ut if MI does that via management interface, it can be done)</div><div clas=
s=3D"gmail_quote"><br></div></span><div class=3D"gmail_quote">That&#39;s ex=
actly what MI-GUI it does -- both certificate password and username/passwor=
d=C2=A0</div><div class=3D"gmail_quote">are=C2=A0passed through the managem=
ent interface. Locally, I have patched it to pass the=C2=A0</div><div class=
=3D"gmail_quote">certificate key as well although we don&#39;t normally use=
 that option.</div><span class=3D"HOEnZb"><font color=3D"#888888"><div clas=
s=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Selva</div></font></=
span></div></div></div>
</div><br></div>

--089e01538bccdaf6760505f10b82--

