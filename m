References: <1464668569-6480-1-git-send-email-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <61d8d41f-4c77-5235-a202-642983d494a3@...1227...>
Date: Tue, 31 May 2016 10:37:34 +0200
MIME-Version: 1.0
In-Reply-To: <1464668569-6480-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Add an option to filter options
 received from server
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
To: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net



Am 31.05.16 um 06:22 schrieb Selva Nair:
> +#define PULL_FILTER_LIST_SIZE 64
We already have dymanic lists, used for ignore-unknown-options and
--route, any reason not to use them here?

Arne

