References: <1505166722-5409-1-git-send-email-steffan.karger@...1435...>
 <1536916459-25900-1-git-send-email-steffan.karger@...1435...>
 <1536916459-25900-2-git-send-email-steffan.karger@...1435...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <be57ea41-fef8-9dd2-aea4-c4a3786da31b@...1227...>
Date: Mon, 17 Sep 2018 17:52:46 +0200
MIME-Version: 1.0
In-Reply-To: <1536916459-25900-2-git-send-email-steffan.karger@...1435...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] mbedtls: make external signing
 code generic
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
To: Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 14.09.18 um 11:14 schrieb Steffan Karger:
> This prepares for reusing this code from the mbedtls pkcs11 implementation.
> The change itself should not have any functional impact.
> 
>

Ack this only reorganises the code and adds a pointer to external key
function.

Acked-By: Arne Schwabe <arne@...1227...>

