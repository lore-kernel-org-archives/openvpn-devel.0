Date: Tue, 28 Jun 2022 16:41:10 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YrsTBsdlITfcP178@...2678...>
References: <20220505114322.6460-1-frank@...2641...>
MIME-Version: 1.0
In-Reply-To: <20220505114322.6460-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] Introduce macros for the returns values
 of key_state_*
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

Note that this patch is wrong. Do not waste time reviewing it. Maybe at
some point I will send a v2. But since it is not high priority it might
take some time.

On Thu, May 05, 2022 at 01:43:22PM +0200, Frank Lichtenheld wrote:
> I think that makes the code slightly more readable.
> 
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>  src/openvpn/ssl.c         | 20 +++++++++---------
>  src/openvpn/ssl_backend.h | 35 ++++++++++++++++++-------------
>  src/openvpn/ssl_mbedtls.c | 44 +++++++++++++++++++--------------------
>  3 files changed, 52 insertions(+), 47 deletions(-)
> 
> Might conflict with some of Arne's handshake patches.
> 
[...]

-- 
  Frank Lichtenheld

