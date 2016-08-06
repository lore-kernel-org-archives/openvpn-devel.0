MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Sat, 6 Aug 2016 00:04:39 -0400
Message-ID: <CAKuzo_jO0FLo=xMakh1yB6_h=huE4Pqp6Xtk2QEgXikeui-F6w@...278...>
Content-Type: multipart/alternative; boundary=001a114042ea6540f505395f49d0
Subject: [Openvpn-devel] block-outside-dns and multiple tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114042ea6540f505395f49d0
Content-Type: text/plain; charset=UTF-8

Hi,

It has been reported (Trac 718) that --block-outside-dns on multiple
tunnels blocks all DNS traffic. My tests appear to confirm this.

Apparently this is due to each openvpn instance adding filters to
independent sublayers. With two tunnels we get port 53 filters in two
sublayers:

sublayer 1: permit openvpn, permit tap1, block all  (in that order)
sublayer 2: permit openvpn, permit tap2, block all

Filter arbitration works roughly like this: filters in each sublayer are
parsed in order of priority and stops at the first match. Then the result
from all sublayers are considered in order of priority in determining the
final action: a block is final and by default a permit may be overridden by
block in lower priority sublayers. So for traffic through tap1, we get
permit from sublayer 1 and block from sublayer 2 leading to a block etc.

This could partially mitigated by making the permit tap1/tap2 filters hard
(they are soft by default -- i.e may be overridden). I say partially
because only one of the "permit tap" filters can be thus protected.

I see two ways to allow dns traffic through all tunnels for which
--block-outside-dns is set

1. Add all filters to a the default sublayer  --- this is the easiest
option but not ideal: cluttering the default sublayer with custom filters
may not not be considered a good practice.

2. Add all filters to a common custom sublayer. This requires a pre-defined
UUID that could be used to define the sublayer and shared between all
instances of openvpn.

For UUID,
(a) generate a machine-specific UUID at install time, save in the registry
and use it as the sublayer key

OR

(b) hard code a UUID in the executable and use it as the sublayer key

I prefer (b) as its simpler.

Note that each additional instances will add duplicate filters like "permit
openvpn" or a low priority "block all". This is required as these filters
are added in a dynamic session so that they disappear if the process
terminates or crashes without removing the filters. As parsing filters
within a sublayer stops as soon as a match (permit or block)  is found, no
performance penalty is expected. In any case it will have less overhead
than the current situation with multiple sublayers.

Any suggestions?

Selva

--001a114042ea6540f505395f49d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>It has been reported (Trac 718) tha=
t --block-outside-dns on multiple tunnels blocks all DNS traffic. My tests =
appear to confirm this.</div><div><br></div><div>Apparently this is due to =
each openvpn instance adding filters to independent sublayers. With two tun=
nels we get port 53 filters in two sublayers:</div><div><br></div><div>subl=
ayer 1: permit openvpn, permit tap1, block all=C2=A0 (in that order)<br></d=
iv><div>sublayer 2: permit openvpn, permit tap2, block all</div><div><br></=
div><div>Filter arbitration works roughly like this: filters in each sublay=
er are parsed in order of priority and stops at the first match. Then the r=
esult from all sublayers are considered in order of priority in determining=
 the final action: a block is final and by default a permit may be overridd=
en by block in lower priority sublayers. So for traffic through tap1, we ge=
t permit from sublayer 1 and block from sublayer 2 leading to a block etc.=
=C2=A0</div><div><br></div><div>This could partially mitigated by making th=
e permit tap1/tap2 filters hard (they are soft by default -- i.e may be ove=
rridden). I say partially because only one of the &quot;permit tap&quot; fi=
lters can be thus protected.<br></div><div><br></div><div>I see two ways to=
 allow dns traffic through all tunnels for which --block-outside-dns is set=
<br></div><div><br></div><div>1. Add all filters to a the default sublayer=
=C2=A0 --- this is the easiest option but not ideal: cluttering the default=
 sublayer with custom filters may not not be considered a good practice.<br=
></div><div><br></div><div>2. Add all filters to a common custom sublayer. =
This requires a pre-defined UUID that could be used to define the sublayer =
and shared between all instances of openvpn. <br><br>For UUID,</div><div>(a=
) generate a machine-specific UUID at install time, save in the registry an=
d use it as the sublayer key</div><div><br></div><div>OR</div><div><br></di=
v><div>(b) hard code a UUID in the executable and use it as the sublayer ke=
y</div><div><br></div><div>I prefer (b) as its simpler.</div><div><br></div=
><div>Note that each additional instances will add duplicate filters like &=
quot;permit openvpn&quot; or a low priority &quot;block all&quot;. This is =
required as these filters are added in a dynamic session so that they disap=
pear if the process terminates or crashes without removing the filters. As =
parsing filters within a sublayer stops as soon as a match (permit or block=
)=C2=A0 is found, no performance penalty is expected. In any case it will h=
ave less overhead than the current situation with multiple sublayers.</div>=
<div><br></div><div>Any suggestions?</div><div><br></div><div>Selva</div></=
div>

--001a114042ea6540f505395f49d0--

