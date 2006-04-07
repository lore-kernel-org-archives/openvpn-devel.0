Message-ID: <44361E0F.3020306@...607...>
From: Nejc Skoberne <nejc@...607...>
MIME-Version: 1.0
References: <44317DED.3000801@...607...> <20060404141212.GA19356@...608...>
In-Reply-To: <20060404141212.GA19356@...608...>
Content-Type: multipart/mixed;
 boundary="------------000502040206040604090209"
Subject: [Openvpn-devel] Many pushed routes
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
Date: Fri Apr  7 01:10:01 2006
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000502040206040604090209
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hi again,

>> Any ideas how could I fix this? I would need to hard-recode the buffer 
>> length (1024)?
> 
> Take a look to the change log of OpenVPN. It says:
> 
>   To increase the push list capacity (must be done on both
>   client and server), increase TLS_CHANNEL_BUF_SIZE in
>   common.h (default=1024).
> 
> So if you are changing this macro definition you should
> be able to use longer lists.

so there is no other way than to compile the Windows version too? It doesn't look
really trivial to get the DDK stuff from Microsoft to be able to compile OpenVPN
for windows.

Why is this limit so low anyway? Would it really hurt anything so badly if it was
let's say 4 times of what it is currently?

Thanks,
Nejc

--------------000502040206040604090209
Content-Type: text/x-vcard; charset=utf-8;
 name="nejc.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nejc.vcf"

begin:vcard
fn;quoted-printable:Nejc =C5=A0koberne
n;quoted-printable:=C5=A0koberne;Nejc
email;internet:nejc@...607...
tel;fax:+38653810387
tel;cell:+38631883217
x-mozilla-html:FALSE
version:2.1
end:vcard


--------------000502040206040604090209--

