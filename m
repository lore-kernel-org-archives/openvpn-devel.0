References: <1505166722-5409-1-git-send-email-steffan.karger@...1435...>
 <1536916459-25900-1-git-send-email-steffan.karger@...1435...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <074fd9e4-1600-b3cf-ed4c-49bcc15e5a88@...1227...>
Date: Mon, 17 Sep 2018 17:52:49 +0200
MIME-Version: 1.0
In-Reply-To: <1536916459-25900-1-git-send-email-steffan.karger@...1435...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Do not load certificate from
 tls_ctx_use_external_private_key()
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
> The cert and key loading logic surrounding management-external-key and
> management-external cert was somewhat intertwined.  Untangle these to
> prepare for making the external key code more reusable.
> 
> The best part is that this even reduces the number of lines of code.
> 

ACK. The previous code is more an artefact of MF_EXTERNAL_KEY and when
it was introduced that the simplicification wasn't made back then.

Acked-By: Arne Schwabe <arne@...1227...>


