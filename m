References: <5731B295.4040301@...515...> <5736E6CF.7030205@...68...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <573706D9.8020107@...2080...>
Date: Sat, 14 May 2016 13:07:05 +0200
MIME-Version: 1.0
In-Reply-To: <5736E6CF.7030205@...68...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3.11 released
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

On 14/05/16 10:50, Matthias Andree wrote:
> Am 10.05.2016 um 12:06 schrieb Samuli Sepp=E4nen:
>> The OpenVPN community project team is proud to release OpenVPN 2.3.11.=20
>> It can be downloaded from here:
>>
>> <http://openvpn.net/index.php/open-source/downloads.html>
>>
>> This release fixes two vulnerabilities: a port-share bug with DoS=20
>> potential and a buffer overflow by user supplied data when using pam=20
>> authentication. In addition a number of small fixes and improvements are=
=20
>> included. A full list of changes is available here:
>>
>> <https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn23>
>=20
> I was wondering... do we have CVE references or similar unique
> identifiers, which I could then use - for instance - in the FreeBSD
> vulnerability database?

We have a few annotations to commits which references CVEs.  The tricky thi=
ng
is that we might have committed fixes before a CVE number have been assigne=
d.

In addition we also have the security announcements wiki page which mentions
CVE references: <https://community.openvpn.net/openvpn/wiki/SecurityAnnounc=
ements>


--=20
kind regards,

David Sommerseth

