MIME-Version: 1.0
References: <20210615125616.344-1-lstipakov@...277...>
 <202106151327.15FDRSdV029284@...2054...>
In-Reply-To: <202106151327.15FDRSdV029284@...2054...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 15 Jun 2021 17:31:02 +0300
Message-ID: <CAGyAFMXZF1KwRqF6Yu9wH9tNCfck9r3eJhHMqSCyOi6jKirtLw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: GitHub actions: add MSVC
 build
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
To: Gert Doering <gert@...1296...>
Cc: Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

> Will this put build artefacts somewhere where people can download
> and test MSVC builds?  Or is it "just openvpn.exe", but not a complete
> installer?  The file looks like "*.exe and *.dll" (but at least this).

One could download artifacts from https://github.com/OpenVPN/openvpn/actions,
for example https://github.com/OpenVPN/openvpn/actions/runs/939447024
(latest master).
At the moment it is .exe and .dll.

Building installer requires openvpn-build. I think this is something
Samuli works on (related to buildbot).

> Where does it report compile errors to?

At the moment to GitHub Actions page
(https://github.com/OpenVPN/openvpn/actions). If needed we could
look into email notifications (and maybe IRC?).

-Lev

