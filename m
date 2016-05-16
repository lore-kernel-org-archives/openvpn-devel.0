References: <5731B295.4040301@...515...> <5736E6CF.7030205@...68...>
	<20160516120332.GH53051@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5739E849.3010700@...2080...>
Date: Mon, 16 May 2016 17:33:29 +0200
MIME-Version: 1.0
In-Reply-To: <20160516120332.GH53051@...1296...>
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net

On 16/05/16 14:03, Gert Doering wrote:
> Hi,
>=20
> On Sat, May 14, 2016 at 10:50:23AM +0200, Matthias Andree wrote:
>> Am 10.05.2016 um 12:06 schrieb Samuli Sepp=E4nen:
>>> The OpenVPN community project team is proud to release OpenVPN 2.3.11.=
=20
>>> It can be downloaded from here:
>>>
>>> <http://openvpn.net/index.php/open-source/downloads.html>
>>>
>>> This release fixes two vulnerabilities: a port-share bug with DoS=20
>>> potential and a buffer overflow by user supplied data when using pam=20
>>> authentication. In addition a number of small fixes and improvements ar=
e=20
>>> included. A full list of changes is available here:
>>>
>>> <https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn23>
>>
>> I was wondering... do we have CVE references or similar unique
>> identifiers, which I could then use - for instance - in the FreeBSD
>> vulnerability database?
>=20
> Not for these two - these sound scary, but are really edge cases that
> are very unlikely to be a problem for most users in practice.  So we
> didn't go out and fetch a CVS number - maybe we should have, but we're
> still learning.  And we need more people to do the routine chores, like,
> "organize proper handling of possibly security relevant patches"...
>=20
> After release, I saw a note about Fedora issueing updates, which referenc=
ed
> "OPENVPN-2311-1" and "OPENVPN-2311-2" - though I'm not sure if these are
> Fedora-assigned or DFN-CERT...
>=20
> https://portal.cert.dfn.de/adv/DFN-CERT-2016-0739/

AFAIK, those OPENVPN-2311-{1,2} numbers are created by dfn.de. I've
never heard, noticed or seen any traces of Fedora nor Red Hat requesting
any CVE numbers for these specific issues.

In hindsight I agree that we probably should have at least considered
asking for a CVE numbers in these cases.


--=20
kind regards,

David Sommerseth

