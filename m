References: <1544210258-8754-1-git-send-email-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <758bbd35-f9e8-5efa-7dc5-a8c739bb7280@...1227...>
Date: Wed, 23 Jan 2019 10:56:28 +0100
MIME-Version: 1.0
In-Reply-To: <1544210258-8754-1-git-send-email-selva.nair@...277...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH 1/2] Move OpenSSL vs CNG signature
 digest type mapping to a function
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
To: selva.nair@...277...
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 07.12.18 um 20:17 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> Also add a function to map  OpenSSL padding identifier to
> corresponding CNG constant.
> 
> This is to help add support for additional padding
> types: only refactoring, no functional changes.
> 

I have no compile and used tested it but the code looks good.

Acked-By: Arne Schwabe <arne@...1227...>

Arne

