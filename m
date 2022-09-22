MIME-Version: 1.0
References: <20220922125822.313-1-lstipakov@...277...>
 <CAKuzo_gJW_dPeHm7k7HiKSpXzf06bPxLaZ7Wqj2GdKzosnVKOA@...278...>
In-Reply-To: <CAKuzo_gJW_dPeHm7k7HiKSpXzf06bPxLaZ7Wqj2GdKzosnVKOA@...278...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 22 Sep 2022 17:47:13 +0300
Message-ID: <CAGyAFMWt=8uPi4yZPgCvxdwXhX9hYred_OZJ=0d3W+mFh1VTCg@...278...>
Subject: Re: [Openvpn-devel] [PATCH release/2.5] msvc: add branch name and
 commit hash to version output
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

Hi,

I've sent v2 with copyright year and "not-a-git" -> "unknown" fix.

(I forgot to name master patch to PATCH v2)

Yes, when doing releases we do git checkout. I have tested MSI
installers produced by openvpn-build GitHub automation, which uses the
same script (build-and-package.ps1) which release build process is
using.

-Lev

