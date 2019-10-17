References: <1571304533-15614-1-git-send-email-lstipakov@...277...>
From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
Message-ID: <25c5ecd5-cd2c-1867-07ef-bcc90327cc73@...2318...>
Date: Thu, 17 Oct 2019 12:39:38 +0200
MIME-Version: 1.0
In-Reply-To: <1571304533-15614-1-git-send-email-lstipakov@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] msvc: OpenSSL 1.1.0 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On 17.10.19 11:28, Lev Stipakov wrote:
> Since we release Windows client with OpenSSL 1.1.0,
> it makes sense to switch to this version in VS build.
> 
> This patch adds msvc-specific defines which imply
> that underlying OpenSSL is 1.1.0.

"Version 1.1.0 will be supported until 2019-09-11" [1].

Is there a plan to update to 1.1.1 for the Windows client?

Regards,
François

[1] https://www.openssl.org/policies/releasestrat.html

