Message-ID: <4FA3E792.8000902@...515...>
Date: Fri, 04 May 2012 17:28:34 +0300
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <CAAhp1KAp8DDJvgE9CTDST8HEGO4HTiMDmv88sTMpNxtWptyX+g@...278...>
	<CAOazyz35GLCBFFBfZe8KfXZerozZt3ULYD03mFtbhkS6ruxWDg@...278...>
	<CAAhp1KAyH3MkeAn7YS_E1474mUbjzTMeqztFNmc-RKD6JZgTyw@...278...>
	<CAAhp1KCJBqZfjKTRC28wk6g5Bkj=-8cP_oe--cY+cJ82-paNsw@...278...>
	<20120503071459.GM1359@...1296...>
	<CAAhp1KCovS4w-+tvPeaHA8xW8v4+KKmCD+Nt2XVjmkKdSuJG4g@...278...>
	<20120503110253.GO1359@...1296...>
In-Reply-To: <20120503110253.GO1359@...1296...>
Subject: Re: [Openvpn-devel] Does OpenVPN Support Unicode Username and
	Password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Alon Bar-Lev <alon.barlev@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


>> And it will really help if you can
>> point out the exact version's of OpenVPN access server and OpenVPN conne=
ct
>> client which support UTF8 username's and Passwords.
> I have no idea.  This list is mainly driven by the community developers,
> while OpenVPN Access Server is a commercial product with commercial
> support - sharing bits of the code base, but not all of it.  My guess
> would be that AS doesn't do UTF8 yet, but you'd really need to ask that
> question to your support contacts.
>
> gert
Afaik the OpenVPN in AS is based on this version of the 2.1.x tree:

<http://openvpn.net/index.php/open-source/documentation/miscellaneous/62-su=
bversion-repository.html>

It's essentially using OpenVPN 2.1.4 with a number of patches written
with AS in mind. My bet is that UTF-8 is not supported: lots of stuff
from that SVN tree has been merged with latest development code, but not
much has moved the other direction.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


