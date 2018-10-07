References: <20181007100032.17060-1-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <35451538-a625-5caf-d903-bc7a80397d2b@...1227...>
Date: Sun, 7 Oct 2018 14:46:08 +0300
MIME-Version: 1.0
In-Reply-To: <20181007100032.17060-1-steffan@...1856...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] Fix use-after-free in
 tls_ctx_use_management_external_key
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 07.10.18 um 13:00 schrieb Steffan Karger:
> Commit 98bfeeb4 changed our openssl backend implementation of
> tls_ctx_use_management_external_key() to no longer use
> tls_ctx_load_cert_file_and_copy(), but still free'd 'cert'. Which it no
> longer should do. Credits go to Arne for spotting the issue (even though
> it was missed during the review).
> 
> The offending commit is only recently applied to the master branch, so was
> never part of a OpenVPN release. For that reason I did not do full impact
> analysis.
> 


ACK. I already tested this on my on side.

Acked-By: Arne Schwabe


Arne

