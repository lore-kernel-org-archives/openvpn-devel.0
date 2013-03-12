From: Peter Caprioli <petercap@...530...>
Date: Tue, 12 Mar 2013 11:08:29 +0000
Message-ID: <C673F57BE2DD3148AC2DD4AF464686F901BEBFC7@...1815...>
References: <C673F57BE2DD3148AC2DD4AF464686F901BBDB56@...1815...>
	<1363032625-23311-1-git-send-email-gert@...1296...>
	<513E4DEB.7000403@...1227...>
	<1CED409804E2164C8104F9E623B08B9013B8D6EDA6@...1436...>,
	<20130312100706.GN953@...1296...>
In-Reply-To: <20130312100706.GN953@...1296...>
Content-Language: sv-SE
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2] Repair "tcp server queue
	overflow"	brokenness, more <stdbool.h> fallout.
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I'll ACK the bool -> int patch, it resolves the issue in ticket 263.
________________________________________
Fr=E5n: Gert Doering [gert@...1296...]
Skickat: den 12 mars 2013 11:07
Till: Steffan Karger
Cc: openvpn-devel@lists.sourceforge.net
=C4mne: Re: [Openvpn-devel] [PATCH v2] Repair "tcp server queue overflow" b=
rokenness, more <stdbool.h> fallout.

Hi,

On Tue, Mar 12, 2013 at 09:32:36AM +0100, Steffan Karger wrote:
> Shouldn't the return type be size_t or at least unsigned int, as mbuf->le=
n is also of type unsigned int?

Well, unsigned int, as ->len is not a size_t.

Not that it makes any real difference as we're talking about a range
between "0" and "65" here.  But anyway.  Patch v2 is below.

gert
--
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

