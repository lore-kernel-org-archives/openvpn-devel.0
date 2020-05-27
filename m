References: <20200519220004.25136-1-arne@...1227...>
 <20200519220004.25136-5-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d1345647-58e8-9d7c-8b01-470f90d8e313@...2080...>
Date: Wed, 27 May 2020 23:10:06 +0200
MIME-Version: 1.0
In-Reply-To: <20200519220004.25136-5-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 4/5] Implement sending AUTH_PENDING
 challenges to clients
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 20/05/2020 00:00, Arne Schwabe wrote:
> This implements sending AUTH_PENDING and INFO_PRE messages to clients
> that indicate that the clients should be continue authentication with
> a second factor. This can currently be out of band (openurl) or a normal
> challenge/response two like TOTP (CR_TEXT).
> 
> Unfortunately this patch spend so much time in review in openvpn2 that
> the corosponding IV_SSO commit in openvpn3 (34a3f264) already made its
> way to released products so changing this right now is difficult.
> 
> https://github.com/OpenVPN/openvpn3/commit/34a3f264f56bd050d9b26d2e7163f88af9a559e2
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/management-notes.txt | 86 ++++++++++++++++++++++++++++++++++++++++
>  src/openvpn/manage.c     | 46 +++++++++++++++++++++
>  src/openvpn/manage.h     |  3 ++
>  src/openvpn/multi.c      | 19 +++++++++
>  src/openvpn/push.c       | 24 +++++++++++
>  src/openvpn/push.h       |  7 ++++
>  6 files changed, 185 insertions(+)
> 
[...]

Only compile tested, as I've done quite some testing earlier.  Requested
changes are in, with the exception of IV_SSO which we can't change now.

Acked-By: David Sommerseth <davids@...515...>

-- 
kind regards,

David Sommerseth
OpenVPN Inc


