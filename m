References: <20210308114405.19066-1-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <60b13347-661e-0521-913e-017ca62bee19@...1227...>
Date: Mon, 8 Mar 2021 12:49:04 +0100
MIME-Version: 1.0
In-Reply-To: <20210308114405.19066-1-gert@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Fix EVP_PKEY_CTX_... compilation with
 LibreSSL
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 08.03.21 um 12:44 schrieb Gert Doering:
> Commit 06f6cf3ff850f29 introduced use of newer OpenSSL functions
> for the TLS 1.0-1.1 PRF, to make OpenVPN work with FIPS-enabled OpenSSL.
> 
> LibreSSL masquerades as "very new OpenSSL" but does not have these
> functions (or at least not on the OpenBSD system tested), so compilationg
> breaks.
> 
> Add a "but not if LibreSSL" check to the OpenSSL version check, as we
> do in other places.
>

I have to say that I am not really surprised by this but at least
currently while we still support OpenSSL 1.0.2 it is not very intrusive.

Acked-By: Arne Schwabe <arne@...1227...>


