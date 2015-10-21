From: "Morris, Russell" <rmorris@...1315...>
Date: Wed, 21 Oct 2015 11:54:41 +0000
Message-ID: <SN1PR08MB13915E1863B6616C835AA9B4B9380@...2065...>
References: <mailman.84319.1445380747.12779.openvpn-devel@lists.sourceforge.net>
	<562734CD.6080706@...1420...>
In-Reply-To: <562734CD.6080706@...1420...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?
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
To: Christian Rank <christian.rank@...1420...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Lots of discussion on this - awesome to see! Perhaps a dumb question, but I=
 can see a few different ways to go on this, as I see comments about servic=
es, applications, etc. ... so a couple thoughts,
- is the intention to run a service (like NSSM?) that keeps openvpn.exe "al=
ive" (restarting it as necessary), so it's always up and running? I admit, =
I somewhat like this approach, one running application for each config file=
. Then control it through the management interface. Or,
- do folks prefer to have "control application" bring openvpn.exe up and do=
wn? I have tried this, and it's a bit messy, but it is functional also.

Thoughts?

I do believe there may also be TAP related stability issues, but that may b=
e an artifact of openvpn.exe crashing - I guess the first step is to get op=
envpn.exe stable?

Thanks,
... Russell



-----Original Message-----
From: Christian Rank [mailto:christian.rank@...1420...]=20
Sent: Wednesday, October 21, 2015 1:47 AM
To: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] Creating a Windows team for OpenVPN?

On 21.10.2015 00:39, openvpn-devel-request@lists.sourceforge.net wrote:
> From: ValdikSS <iam@...2070...>
>=20
> By the way, there is an open-source SecurePoint VPN client (https://sourc=
eforge.net/projects/securepoint/) which handles current versions of Windows=
 very well.

Hi,

it seems that the current version of Securepoint's VPN client is no
longer open source. The repo at
> https://github.com/Securepoint/openvpn-client
has the source for version 1.0.3 (last commit 2 years ago), whereas the
current version (binaries) on sf.net is 2.0.10.

Securepoint's website
http://www.securepoint.cc/products-vpn-clients.html
says "The Securepoint OpenVPN client is free of charge" - the term "open
source" is not mentioned.

Regards,
	Christian

--=20
Dr. Christian Rank
Rechenzentrum Universit=E4t Passau
Bereich Netzwerk und Telekommunikation
IT-Sicherheitsbeauftragter der Universit=E4t
Innstr. 33
D-94032 Passau
GERMANY


