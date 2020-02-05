Date: Wed, 5 Feb 2020 16:40:13 +0100
From: Domagoj Pensa <domagoj@...2540...>
Message-ID: <20200205154013.GA9536@...2540...>
References: <20200205124615.15758-1-domagoj@...2540...>
 <20200205124615.15758-3-domagoj@...2540...>
 <20200205130511.GM1431@...1296...>
 <20200205131828.GA16251@...2540...>
 <CAKuzo_h2XNEm+UnGEvcoF5g2rwDdsTMTjtA-p0uHdsMu7HGP2w@...278...>
 <CAKuzo_i3-3xXYP+f+GAJKtDVOajD5iE+vg9fa2XrHUbg1PFzSg@...278...>
MIME-Version: 1.0
In-Reply-To: <CAKuzo_i3-3xXYP+f+GAJKtDVOajD5iE+vg9fa2XrHUbg1PFzSg@...278...>
Subject: Re: [Openvpn-devel] Fwd:  [PATCH 2/2] Fix linking issues on MinGW
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

On Wed, Feb 05, 2020 at 10:28:38AM -0500, Selva Nair wrote:
> Are you building without optimization? Please try using the latest
> openvpn-build (or just add -O2 to complier options).

Yes, that was it!

When Lev said that he doesn't have problems with build, I've noticed that he 
is using script build-complete from windows-nsis.

I didn't want installer build, just binaries, so I followed  instructions 
from README and generic/README and thus I used generic/build.

But that doesn't include -O2 and I get mentioned error when linking.

In windows-nsis/build-complete there are additional flags "-O2 -flto" and 
that's why Lev doesn't have issues and we are using same tools and OS 
versions.

Those additional flags where added by Lev in commit 3eb61bb in 
openvpn-build.

Problem solved, now I know for the future.

But still it would be nice to somehow "fix" this for others, by either 
updating READMEs, adding -O2 to generic/build script or apply patch I've 
sent that helped me and links with optimization off.

Maybe doing all that won't be bad.

Thank you all!

Domagoj

