Message-ID: <43665886.6040901@...277...>
From: Alon Bar-Lev <alon.barlev@...277...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] substring subject matching suggestion for new
 pkcs11 support
References: <4366228B.8060007@...486...>
In-Reply-To: <4366228B.8060007@...486...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Oct 31 09:52:16 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Albert Siersema <appie@...486...>
Cc: openvpn-devel@lists.sourceforge.net

Albert Siersema wrote:
> In pkcs11.c instead of
> if (!strcmp (szId, szSubject))
> could strstr() to match on substring in the subject ?
> (akin cryptoapicert "SUBJ:...")
> This would be easier in distributing config files to clients.

Hello,

I don't like fuzzy matching, this is why I provide the 
subject name in the show-pkcs11-objects.

Fuzzy matching causes many problems... What happens if more 
than one certificate matches? Should I select the first? the 
last? the best?
What if the wrong certificate matches? And the user 
accidentally perform private key operation with the wrong key?

Best Regards,
Alon Bar-Lev.

