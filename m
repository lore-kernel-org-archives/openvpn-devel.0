From: Arne Schwabe <arne@...1227...>
References: <500813015-27739-1-git-send-email-arne@...1227...>
 <1520425796-22486-1-git-send-email-arne@...1227...>
Message-ID: <bf1326d5-6f04-a6c5-cb5f-1c7a1824f9ba@...1227...>
Date: Wed, 7 Mar 2018 13:42:21 +0100
MIME-Version: 1.0
In-Reply-To: <1520425796-22486-1-git-send-email-arne@...1227...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v4] Print ec bit details,
 refuse management-external-key if key is not RSA
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
To: openvpn-devel@lists.sourceforge.net

Am 07.03.18 um 13:29 schrieb Arne Schwabe:
> V2: Print also curve details, add missing ifdef
> V3: Goto err instead of using M_FATAL, format fixes, use EC_GROUP_get_curve_name + OBJ_nid2sn instead of ECPKParameters_print, add compat headers for 1.0.2
> V4: Formatting changes and change M_ERR to M_WARN


Resend by accident please ignore.

Arne

