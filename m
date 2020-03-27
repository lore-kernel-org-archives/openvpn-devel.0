References: <20191109151306.18597-1-arne@...1227...>
 <20191109151306.18597-4-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <904629c3-4bd4-a31e-30c7-70f100b26473@...2080...>
Date: Fri, 27 Mar 2020 22:09:24 +0100
MIME-Version: 1.0
In-Reply-To: <20191109151306.18597-4-arne@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2 4/5] Implement sending SSO challenge
 to clients
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

On 09/11/2019 16:13, Arne Schwabe wrote:
> This implements sending AUTH_PENDING and INFO_PRE messages to clients
> that indicate that the clients should be continue authentication with
> a second factor. This can currently be out of band (openurl) or a normal
> challenge/response 2FA like TOTP (CR_TEXT).
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/management-notes.txt | 26 +++++++++++++++++++++++
>  src/openvpn/manage.c     | 46 ++++++++++++++++++++++++++++++++++++++++
>  src/openvpn/manage.h     |  3 +++
>  src/openvpn/multi.c      | 19 +++++++++++++++++
>  src/openvpn/push.c       | 24 +++++++++++++++++++++
>  src/openvpn/push.h       |  2 ++
>  6 files changed, 120 insertions(+)

Code and management notes looks reasonable.  But again, it would be good to
have a way to test this properly to avoid regressions later on.  Since this is
also a more advanced authentication method, having good test methods is even
more critical.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


