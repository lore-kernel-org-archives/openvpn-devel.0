Message-ID: <5346C9A6.2010807@...1147...>
Date: Thu, 10 Apr 2014 18:41:10 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <1CED409804E2164C8104F9E623B08B90170093CD3A@...1436...>	<5343E392.1010803@...1800...>	<1CED409804E2164C8104F9E623B08B90170093CE96@...1436...>	<5343FF41.3080406@...1879...>	<5344111D.3080408@...515...>	<5344145F.3010702@...515...>	<53442B8A.2030105@...515...>	<CAFHpkQE-6kqi+RT4oF_F+4YULRd=NtJ3rCNK-YR+JrGM47s-sw@...278...>	<53450525.4010704@...1227...>	<CAFHpkQEuf35w0CuEDvYrRARZR2-vmcZQAh6eA=8q=XkdertD-w@...278...>	<20140409084530.GQ16637@...1296...>
	<53452245.9020103@...1294...>
In-Reply-To: <53452245.9020103@...1294...>
Subject: Re: [Openvpn-devel] Heartbleed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: e.lohmann@...1294..., openvpn-devel@lists.sourceforge.net

On 09/04/14 12:34, Eike Lohmann wrote:
> Am 09.04.2014 10:45, schrieb Gert Doering:
>> This is not trivial to set up, and might not be worth for every client
>> out there - but if you're truly concerned about your data, upgrade the
>> client, revoke the old key+certificate, reissue new keys.
> How does revokation Lists work with openvpn?
>
>
- revoke a certificate and generate a CRL using easy-rsa's 'revoke-full' 
(or your preferred solution for PKI)
- add
   crl-verify <full path to crl.pem file>
to your server config
- restart openvpn

you can also use a directory containing .r0 files if you have multiple 
CAs + CRLs that you need to support.


HTH,

JJK


