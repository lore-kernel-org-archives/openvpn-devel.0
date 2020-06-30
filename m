Message-ID: <1593534757.4124.0.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Tue, 30 Jun 2020 09:32:37 -0700
In-Reply-To: <20200629175109.94276-1-gert@...1296...>
References: <20200629175109.94276-1-gert@...1296...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Fix 'engine' unit test on FreeBSD
 (specifically 'not GNU make')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

On Mon, 2020-06-29 at 19:51 +0200, Gert Doering wrote:
> The rules to generate $(builddir)/openssl.cnf from
> $(srcdir)/openssl.cnf.in only worked for GNU Make.  BSD make needs
> the rules more explicit, and the target must not have a directory
> specification (fixes commit 542c69c37).

This definitely works for me on Linux.

James


