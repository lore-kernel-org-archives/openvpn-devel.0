Date: Mon, 24 Feb 2025 14:48:22 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Z7x4pi0/J5IkFEXx@...2685...>
References: <CAAWBBYOr-ZKmr3754DqzkssCr04C=n75C4bOihN04nx-4-xVvw@...278...>
 <Z7hqbzqBZG1EC6jR@...2685...>
 <CAAWBBYOgTGFmfpX11FBBG08Z7RWL8qNFV--PgUv++Tpnz_VauQ@...278...>
MIME-Version: 1.0
In-Reply-To: <CAAWBBYOgTGFmfpX11FBBG08Z7RWL8qNFV--PgUv++Tpnz_VauQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add 'localhost' token to client-nat
 network option
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
To: Rafael Gava <gava100@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Sun, Feb 23, 2025 at 03:26:36PM -0300, Rafael Gava wrote:
> Hi Frank,
> 
> Thank you for your feedback. I'll make the changes as per your suggestions
> and resubmit the patch later. My apologies for not realizing that you were
> using a formatting check tool. I installed Uncrustify, and it worked
> perfectly. :-)
> 
> I also wanted to ask about the automated tests on GitHub. Should I fork the
> project and submit the patch there, or should I submit it directly to the
> main project? What is the recommended approach?

If you want to use Github, then fork the repository. Note that we do not
merge Github PRs directly. Actual patch approval only happens in
Gerrit or here on the list (see also 
https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#PatchsubmissionviaGerrit).
So using Github is not required, but it allows you to use the Github
actions basically instantly to get some cross-platform verification
of your work.

Regards,
-- 
  Frank Lichtenheld

