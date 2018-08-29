References: <149619ba-265f-1a7a-6403-f99c6f4b7eac@...1227...>
 <f89c1cbd-4899-432a-5288-1055b5045318@...2080...>
 <20180824191654.GK997@...1296...>
 <a94f7c1d-9d84-477c-0c0c-cc10ba589186@...2080...>
 <db32e7b7-9c8c-6913-eb28-973f3275ec66@...1147...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <b1222ba5-50db-5396-00ce-97861da67c2c@...1435...>
Date: Wed, 29 Aug 2018 18:21:17 +0200
MIME-Version: 1.0
In-Reply-To: <db32e7b7-9c8c-6913-eb28-973f3275ec66@...1147...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Discussion: Moving forward with compression and
 voracle
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On 29-08-18 17:18, Jan Just Keijser wrote:
> Since when can I not type in
> =A0 rm -rf /
> any more ?=A0 did someone build in a flag into the "rm" command to stop me
> from doing so? I sure hope not.

$ sudo docker run --rm debian rm -rf /
rm: it is dangerous to operate recursively on '/'
rm: use --no-preserve-root to override this failsafe

This has been like this for a long while (and not just for debian).

-Steffan

PS: "rm -rf /*" will try to rm (almost) everything ;-)

