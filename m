From: Charles Duffy <cduffy@...294...>
Date: Mon, 08 Jan 2007 11:29:55 -0600
Message-ID: <entv2l$opj$1@...165...>
References: <459DB400.2000602@...334...>
Mime-Version: 1.0
In-Reply-To: <459DB400.2000602@...334...>
Sender: news <news@...165...>
Subject: Re: [Openvpn-devel] client-cert-not-required ==
	client-cert-do-not-check
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Faidon Liambotis wrote:
> Another reason to do it is because it's the obvious thing to do:
> -not-required doesn't mean -do-not-check/-ignored, it means "I will not
> fail if you don't provide it but I will fail if provide one that I can't
> verify", IMHO.

Checking the certificate only if present and treating it as successful 
should it not be present adds no real (non-illusory) security over not 
checking the certificate at all. Leading people to believe that they 
have some additional certificate-provided level of security when using 
certificates in conjunction with client-cert-not-required is thus the 
Wrong Thing as opposed to making it clear that there is no 
certificate-related security provided when client-cert-not-required is 
in use.

Also, modifying the code to add an illusory level of security is more 
work than not having that (illusory-only) security at all.


