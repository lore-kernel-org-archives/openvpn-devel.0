Message-ID: <48EBBE38.2030700@...334...>
Date: Tue, 07 Oct 2008 22:53:28 +0300
From: Faidon Liambotis <paravoid@...334...>
MIME-Version: 1.0
References: <750B64C66078B34D918257A1AC004DB205441F@...1132...>	<9e0cf0bf0809242210x74696837w126ea5caddede127@...278...>	<750B64C66078B34D918257A1AC004DB2054440@...1132...>	<9e0cf0bf0809271144i170c0805uadac7b428223fa7b@...278...>
	<9e0cf0bf0810071208i32b10997l72d25fe1490c6f@...278...>
In-Reply-To: <9e0cf0bf0810071208i32b10997l72d25fe1490c6f@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4] Use CryptoAPI CA store (was
 Re:	[PATCH v3] Use CryptoAPI CA store)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

Alon Bar-Lev wrote:
> On 9/27/08, Alon Bar-Lev <alon.barlev@...277...> wrote:
>>  I prefer to receive patches...
>>  Anyway, this is not exactly what I meant.
>>  Please review latest head.
>>  I did not test this, but it should be correct now as far as the
>>  changes are concerned.
>>  It may not work as the validation process was never tested.
>
> Any news?
Thanks for reviving this. I built it and tried it and seems to work.
I didn't test with revoked or expired certificates, however.

As for warnings there's just a trivial one:
	cryptoapi.c:429: warning: passing arg 2 of `d2i_X509' from 	
			 incompatible pointer type

Regards,
Faidon

