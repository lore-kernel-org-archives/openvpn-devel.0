References: <1469472766-25131-1-git-send-email-steffan@...1856...>
	<bfe78001-1ad6-0470-0166-60de2f77f9e6@...1147...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <e19021fd-508b-0e79-e39e-65dcb4c50882@...1435...>
Date: Tue, 26 Jul 2016 13:02:59 +0200
MIME-Version: 1.0
In-Reply-To: <bfe78001-1ad6-0470-0166-60de2f77f9e6@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Allow ncp-disable and ncp-ciphers to be
 specified in ccd files
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
To: openvpn-devel@lists.sourceforge.net

Hi JJK,

On 26-07-16 04:17, Jan Just Keijser wrote:
> ACK from me, but just to nitpick:
>=20
> we now have an option 'disable-occ' and an option 'ncp-disable' -=20
> wouldn't it make more sense to make it "disable-ncp" as well?

Yes, I considered this, but I like --ncp-disable more because:
 * it has some symmetry with --ncp-ciphers
 * I like the 'hierarchical' --<group>-<property>, like we have now for
e.g. the --tls-* options

But, if the community likes --disable-ncp better, I'm happy to comply.

-Steffan


