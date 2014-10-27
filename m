Message-ID: <544EA7DB.1000801@...1227...>
Date: Mon, 27 Oct 2014 21:15:23 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1414269324-14102-1-git-send-email-steffan@...1856...>
	<1414269324-14102-7-git-send-email-steffan@...1856...>
In-Reply-To: <1414269324-14102-7-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 6/6] openssl: add more descriptive
 message for "no shared cipher" error
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
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Am 25.10.14 22:35, schrieb Steffan Karger:
> Overzealous users using the --tls-cipher option, or users with actual
> incompatible crypto libaries often waste quite some time debugging the
> "no shared cipher" error from openssl. See e.g. trac ticket #359:
> https://community.openvpn.net/openvpn/ticket/359
>
> This change adds a more clear, verb 1 error message reporting the problem
> directly to the user, instead of just printing the openssl error.
>
> S
ACK.

Arne

