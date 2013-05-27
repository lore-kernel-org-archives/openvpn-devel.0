Message-ID: <51A313FE.7050801@...1227...>
Date: Mon, 27 May 2013 10:06:22 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1366393268-27392-1-git-send-email-gert@...1296...>
	<1369044801-7594-1-git-send-email-gert@...1296...>
In-Reply-To: <1369044801-7594-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 4/5 v3] Always push basic set of peer
 info values to server.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Am 20.05.13 12:13, schrieb Gert Doering:
> From: James Yonan <james@...515...>
>
> On the client, allow certain peer info fields to be pushed even if
> push-peer-info isn't specified in the config.
>
> This is needed to allow the compression handshake to work correctly
> (i.e. where the client indicates its support for LZO and/or Snappy).
>
> Fields that have privacy implications such as Mac Address and UV_*
> environment variables will not be pushed to the server as before unless
> push-peer-info is specified by client config.
>
ACK to this patch.

Arne

