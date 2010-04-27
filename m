MIME-Version: 1.0
Content-class: urn:content-classes:message
Date: Tue, 27 Apr 2010 06:32:18 +0200
Message-ID: <7C4973E27A52DB44900D96028C07F41309A005@...1352...>
References: <7C4973E27A52DB44900D96028C07F413099FC1@...1352...>
	<4BD082B2.2030406@...1114...> 
From: =?iso-8859-1?Q?Siegfried_M=FCller_-_MB_Connect_Line_GmbH?=
	<mueller@...1351...>
Subject: [Openvpn-devel] OpenVPN 2.1.1 and "inactive". "ping" is retrigger
	the inactivity timeout!!
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Openvpn-devel@lists.sourceforge.net


>> On 22/04/10 18:40, Siegfried M=FCller - MB Connect Line GmbH wrote:
>> Hi developers,
>>=20
>> does anyone tried the "inactive" option with the openvpn version 2.1.1?
>> I step up from 2.0.1 to 2.1.1 and get the problem, that the client does =
not disconnect after inactivity.
>> If i set the option "ping 0" instead of "ping 10" the inactivity works. =
Could that be a problem, that the new version does retrigger the inactivity=
-timeout with his own ping?
>> any ideas?
>>=20

> Having just poked quickly at the code, it seems that "ping 0" disables th=
e pinging completely.  As a ping packet will cause traffic on the tunnel, t=
he connection will > then not be inactive.  If it worked differently on Ope=
nVPN 2.0, I can understand you are surprised.
>=20
> On the other hand, how the code now looks like, this seems to be the expe=
cted behaviour in OpenVPN 2.1.  So using --ping would disable the
> - --inactive feature indirectly.
>=20
> If this was an intended change or not, that I do not know.  But I'll try =
to remember to mention it on the developers meeting today.
>=20
>=20
> kind regards,
>=20
> David Sommerseth

well, i think openvpn should ignore the own pings for retrigger the inactiv=
ity timeout. Otherwise, you have to know to set --ping 0 if you want to use=
 --inactive and also in this case the server could not recognize the discon=
nected client. Currently the client ignores incoming vpn-pings and did not =
retrigger the inactivity, why only incoming?
kind regards,
Siegfried

