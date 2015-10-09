References: <20140526132551.GA9011@...1915...>
From: David Sommerseth <openvpn.list@...1114...>
Message-ID: <56183D5A.5070805@...1114...>
Date: Sat, 10 Oct 2015 00:19:06 +0200
MIME-Version: 1.0
In-Reply-To: <20140526132551.GA9011@...1915...>
Subject: Re: [Openvpn-devel] [PATCH applied] Add support for Keying Material
 Exporter [RFC 5705]
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Daniel Kubec <niel@...1898...>, openvpn-devel@lists.sourceforge.net

On 26/05/14 15:25, Daniel Kubec wrote:
> Add support for TLS Keying Material Exporters [RFC 5705].
>     
> Keying Material Exporter allow additional keying material to be derived from existing TLS channel. 
> This exported keying material can then be used for a variety of purposes.

These patches have been applied to the git master branch:

* openvpn-rfc5705-v3.patch
commit 685e486e8b8f70c25f09590c24762ff734f94a51
Author: Daniel Kubec <niel@...1898...>
Date:   Thu Mar 12 15:14:20 2015 +0100

    Added support for TLS Keying Material Exporters [RFC-5705]

    Signed-off-by: Daniel Kubec <niel@...1898...>
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Steffan Karger <steffan.karger@...1435...
    Acked-by: David Sommerseth <davids@...1347...>


* openvpn-rfc5705-doc-v3.patch
commit 84604e0bae7216b46642d5a1a443b86f712d53aa
Author: Daniel Kubec <niel@...1898...>
Date:   Thu Mar 12 15:25:42 2015 +0100

    Added document for TLS Keying Material Exporters [RFC-5705]

    [DS: Fixed option prefix from '-' to '--']

    Signed-off-by: Daniel Kubec <niel@...1898...>
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Steffan Karger <steffan.karger@...1435...
    Acked-by: David Sommerseth <davids@...1347...>


* openvpn-rfc5705-sample.patch
commit f7ef7522f5c7e6d4abfa5a0378c2e2ad265c65ec
Author: Daniel Kubec <niel@...1898...>
Date:   Sun Apr 5 00:10:37 2015 +0200

    sample-plugin: TLS Keying Material Exporter [RFC-5705] demonstration plug-in

    Signed-off-by: Daniel Kubec <niel@...1898...>
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: David Sommerseth <davids@...1347...>


-- 
kind regards,

David Sommerseth

