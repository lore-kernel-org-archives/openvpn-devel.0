MIME-Version: 1.0
References: <CAKuzo_i9p-8T1a8guoPmFj2OjvKO5mKC=8WUoFtxzpjayaANxw@...278...>
 <1540117186-10445-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1540117186-10445-1-git-send-email-lstipakov@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 21 Oct 2018 12:31:36 -0400
Message-ID: <CAKuzo_jwZagpBbAu3NehQ1E_N_=UiqOBYOFDrK88zg7-+vsSHA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Introduce openvpn_swprintf() with
 nul termination guarantee
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sun, Oct 21, 2018 at 6:24 AM Lev Stipakov <lstipakov@...277...> wrote:
>
> From: Lev Stipakov <lev@...515...>
>
> Every call to swprintf is followed by line which adds nul terminator. This patch
> introduces openvpn_swprintf() which guarantees nul termination for size > 0.
>
> Same approach as for snprintf / openvpn_snprintf.
>
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
> v2:
>  - rebase on top of master

Thanks. I like to build and do a quick run test except for very
trivial patches.

And, building did expose a small issue:

>
>  src/openvpn/buffer.c          | 17 +++++++++++++++++
>  src/openvpn/buffer.h          | 11 +++++++++++
>  src/openvpn/tun.c             |  3 +--
>  src/openvpnserv/common.c      | 15 +++++++++++++++
>  src/openvpnserv/interactive.c | 18 ++++++------------
>  src/openvpnserv/validate.c    |  3 +--
>  6 files changed, 51 insertions(+), 16 deletions(-)

openvpn_swprintf in common.c has to be declared in one
of the headers (service.h?) too. Missing as of now.

Should have noticed in the last round...

Selva

