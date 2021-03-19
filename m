From: Maximilian Fillinger <maximilian.fillinger@...1435...>
Date: Fri, 19 Mar 2021 17:57:47 +0000
Message-ID: <AM0PR04MB5331CE6158E96B9859C5B478B1689@...2601...>
References: <AM0PR04MB53311DBD4346F75A380F7198B1689@...2601...>
 <20210319173004.GU976@...1296...>
In-Reply-To: <20210319173004.GU976@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Patch] Wipe Socks5 credentials after use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Sorry about that! I'll send it again from my personal account later.

-----Original Message-----
From: Gert Doering [mailto:gert@...1296...]=20
Sent: vrijdag 19 maart 2021 18:30
To: Maximilian Fillinger <maximilian.fillinger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [Patch] Wipe Socks5 credentials after use

Hi,

On Fri, Mar 19, 2021 at 04:45:18PM +0000, Maximilian Fillinger via Openvpn-=
devel wrote:
[..]

The patch itself is OK (I think), but actually applying it will mess up the
Author: information in git, because you are sending from a domain that has =
DMARC p=3Dreject.  So mailman is massacring your From: line into this

From: Maximilian Fillinger via Openvpn-devel <openvpn-devel@...1768...=
ge.net>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20

... and this is what will be the Author of the commit.

Can you send this from an account that is not set up to intentionally harm =
mailing lists?

gert

--
"If was one thing all people took for granted, was conviction that if you  =
feed honest figures into a computer, honest figures come out. Never doubted=
  it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

