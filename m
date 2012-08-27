References: <1345727389.42365.YahooMailNeo@...1744...>
	<50364E1E.7000109@...1114...>
	<1345828643.55420.YahooMailNeo@...1750...>
	<503A8633.5090308@...1114...>
	<1346030651.69898.YahooMailNeo@...1752...>
In-Reply-To: <1346030651.69898.YahooMailNeo@...1752...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----5JVB2C2WQJ5PS7UJCGXSXIV4SGZB6N"
From: Eric F Crist <ecrist@...1286...>
Date: Sun, 26 Aug 2012 20:58:24 -0500
Message-ID: <94588dbd-f523-40eb-b70c-8140d257a72d@...1753...>
Subject: Re: [Openvpn-devel] patch for 2.2.2 to include --script-dir
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Amm Vpn <ammdispose-vpn@...109...>, David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

------5JVB2C2WQJ5PS7UJCGXSXIV4SGZB6N
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There are a few decision makers who have sent NAKs regarding your patch. Th=
is isn't going to be considered further.=20
--=20
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

Amm Vpn <ammdispose-vpn@...109...> wrote:

Hi,

First I just wanted to know if you are the decision maker for OpenVPN?


Because, the reasons/scenarios you are giving do not make sense to me.
You are not at all considering the real danger (a what-if case)

(Do not take it in offensive way please)

I just wanted to make sure I am posting the patch at right place and to
right person.


I am talking about two users here, one the root user who has access to
system and other a plain admin who has access to config file only.
This is a real world scenario in most of cases where assistant just has
access to frontend and IT head has root access.



----- Original Message -----
> From: David Sommerseth <openvpn.list@...1114...>
=20
> Having this as a runtime configuration does not add any restriction in=20
> reality.  You must presume the user have the possibility to tweak the con=
fig=20
> somehow.  And the user is fully capable of discovering a way how to execu=
te=20
> your configs directly, skipping the --scripts-dir.  So you cannot trust t=
he=20
> client config.  So the front-end must protect the OpenVPN executable so i=
t is=20
> the only one who can start an OpenVPN connection.

Can you tell me how user can skip script-dir in my new patch? With example
config? In my opinion I have already taken care of it, if not then I am rea=
dy to
patch that as well.


> Another scenario, if your front-end does not protect the OpenVPN binary, =
a=20
> user can also download an earlier OpenVPN and circumvent this behaviour w=
ith=20
> your own front-end.  So the OpenVPN executable must be protected no matte=
r=20
> what, and your front-end is the only thing which the user should be able =
to=20
> use.  And then this front-end is the only one which truly can protect you=
, by=20
> sanitising the config *before* the OpenVPN executable is started - where =
your=20
> front-end is the only binary which should have access to the OpenVPN bina=
ry.

Isnt that true for any software?? That user can install unpatched binary an=
d do
whatever?? Its like saying, "Hey there is another way a thief can enter the=
 house,
so why not let all the doors open?"

And again in my case (infact in most case where root and frontend is handled
by different people) this would again not be case. As frontend guy has no r=
oot
access, so cant install unpatched version.

Thanks and regards,

AMM


_____________________________________________

Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and=20
threat landscape has changed and how IT managers can respond. Discussions=20
will include endpoint security, mobile security and the latest in malware=20
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_____________________________________________

Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel


------5JVB2C2WQJ5PS7UJCGXSXIV4SGZB6N
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body>There are a few decision makers who have sent NAKs=
 regarding your patch. This isn&#39;t going to be considered further. <br>
-- <br>
Sent from my Android phone with K-9 Mail. Please excuse my brevity.<br><br>=
<div class=3D"gmail_quote">Amm Vpn &lt;ammdispose-vpn@...109...&gt; wrote:<=
blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border=
-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre style=3D"white-space: pre-wrap; word-wrap:break-word; font-family: san=
s-serif">Hi,<br /><br />First I just wanted to know if you are the decision=
 maker for OpenVPN?<br /><br /><br />Because, the reasons/scenarios you are=
 giving do not make sense to me.<br />You are not at all considering the re=
al danger (a what-if case)<br /><br />(Do not take it in offensive way plea=
se)<br /><br />I just wanted to make sure I am posting the patch at right p=
lace and to<br />right person.<br /><br /><br />I am talking about two user=
s here, one the root user who has access to<br />system and other a plain a=
dmin who has access to config file only.<br />This is a real world scenario=
 in most of cases where assistant just has<br />access to frontend and IT h=
ead has root access.<br /><br /><br /><br />----- Original Message -----<br=
 />&gt; From: David Sommerseth &lt;openvpn.list@...1114...&gt;<br />=C2=A0<=
br />&gt; Having this as a runtime configuration does not add any restricti=
on in <br />&gt;
reality.=C2=A0 You must presume the user have the possibility to tweak the =
config <br />&gt; somehow.=C2=A0 And the user is fully capable of discoveri=
ng a way how to execute <br />&gt; your configs directly, skipping the --sc=
ripts-dir.=C2=A0 So you cannot trust the <br />&gt; client config.=C2=A0 So=
 the front-end must protect the OpenVPN executable so it is <br />&gt; the =
only one who can start an OpenVPN connection.<br /><br />Can you tell me ho=
w user can skip script-dir in my new patch? With example<br />config? In my=
 opinion I have already taken care of it, if not then I am ready to<br />pa=
tch that as well.<br /><br /><br />&gt; Another scenario, if your front-end=
 does not protect the OpenVPN binary, a <br />&gt; user can also download a=
n earlier OpenVPN and circumvent this behaviour with <br />&gt; your own fr=
ont-end.=C2=A0 So the OpenVPN executable must be protected no matter <br />=
&gt; what, and your front-end is the only thing which the user should be ab=
le to <br />&gt; use.=C2=A0 And then this
front-end is the only one which truly can protect you, by <br />&gt; saniti=
sing the config *before* the OpenVPN executable is started - where your <br=
 />&gt; front-end is the only binary which should have access to the OpenVP=
N binary.<br /><br />Isnt that true for any software?? That user can instal=
l unpatched binary and do<br />whatever?? Its like saying, "Hey there is an=
other way a thief can enter the house,<br />so why not let all the doors op=
en?"<br /><br />And again in my case (infact in most case where root and fr=
ontend is handled<br />by different people) this would again not be case. A=
s frontend guy has no root<br />access, so cant install unpatched version.<=
br /><br />Thanks and regards,<br /><br />AMM<br /><br /><br /><hr /><br />=
Live Security Virtual Conference<br />Exclusive live event will cover all t=
he ways today's security and <br />threat landscape has changed and how IT =
managers can respond. Discussions <br />will include endpoint security, mob=
ile security and the
latest in malware <br />threats. <a href=3D"http://www.accelacomm.com/jaw/s=
frnl04242012/114/50122263">http://www.accelacomm.com/jaw/sfrnl04242012/114/=
50122263</a>/<br /><hr /><br />Openvpn-devel mailing list<br />Openvpn-deve=
l@lists.sourceforge.net<br /><a href=3D"https://lists.sourceforge.net/lists=
/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/openv=
pn-devel</a><br /></pre></blockquote></div></body></html>=

------5JVB2C2WQJ5PS7UJCGXSXIV4SGZB6N--


