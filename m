References: <1513246897-28171-1-git-send-email-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a0793b6c-79c9-3cc7-4be7-5f66ddee95a2@...1227...>
Date: Thu, 14 Dec 2017 12:05:52 +0100
MIME-Version: 1.0
In-Reply-To: <1513246897-28171-1-git-send-email-steffan@...1856...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH] ssl_openssl: fix compiler warning by
 removing getbio() wrapper
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
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 14.12.17 um 11:21 schrieb Steffan Karger:
> An API change in openssl 1.1 made the BIO_METHOD * returned by BIO_f_ssl()
> and BIO_s_mem() const, as well as the BIO_METHOD * argment of BIO_new()
> const.  This meant that our getbio() function would either have an API
> inconsistent with 1.0 or 1.1.
> 
> The wrapper was basically an ASSERT, so fix this by replacing the wrapper
> with an ASSERT.
> 

Looks good. The wrapper does also not add much clarity or otherwise
functionality.

Acked-by: Arne Schwabe

