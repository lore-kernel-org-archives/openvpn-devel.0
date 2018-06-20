MIME-Version: 1.0
References: <20180620044650.18041-1-rosenp@...277...>
 <20180620050012.GR57262@...1296...>
In-Reply-To: <20180620050012.GR57262@...1296...>
From: Emmanuel Deloget <logout@...260...>
Date: Wed, 20 Jun 2018 14:40:43 +0200
Message-ID: <CAKh=nwE8OzcA1e7et3Xc=MtdanG4SBc7vAFaFGC=7T4_CmsP9w@...278...>
Subject: Re: [Openvpn-devel] [PATCH] OpenSSL: Fix compilation with
 deprecated APIs disabled on 1.1
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
Cc: rosenp@...277..., openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hello Rosen,

On Wed, Jun 20, 2018 at 7:00 AM Gert Doering <gert@...1296...> wrote:
>
> Hi,
>
> On Tue, Jun 19, 2018 at 09:46:50PM -0700, Rosen Penev wrote:
> > Signed-off-by: Rosen Penev <rosenp@...277...>
> > ---
> >  src/openvpn/crypto_openssl.c     |  9 +++++++++
> >  src/openvpn/ssl_openssl.c        | 32 +++++++++++++++++++++++++++++++-
> >  src/openvpn/ssl_verify_openssl.c |  1 +
> >  3 files changed, 41 insertions(+), 1 deletion(-)

Can you give a better explanation of the issue ? (I'm sorry, I try to
follow the discussions on the ML, but I'm kind of slow (and busy,
which does not help)).

Best regards,

-- Emmanuel Deloget

