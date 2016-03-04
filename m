Message-ID: <56D97EFA.9010207@...1147...>
Date: Fri, 04 Mar 2016 13:26:34 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <56D8A6C4.5080803@...2070...>
In-Reply-To: <56D8A6C4.5080803@...2070...>
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: ValdikSS <iam@...2070...>, openvpn-devel@lists.sourceforge.net

Hi,

On 03/03/16 22:04, ValdikSS wrote:
> Hello everyone,
>
> I'm trying to leisurely move from an old existing 1024 bit CA to a new 4096 bit one without a hassle for a clients.
>  From a X.509 perspective it shouldn't be a problem, and I already have new CA self-signed and cross-signed with old CA, it should work just fine.
>
> While there's no problem authenticating clients from both old and new CA using single instance (multiple certificates in --ca are supported, this information is
> documented), I need to send two certificates from OpenVPN server: server certificate, which is signed by new CA, and cross-signed new CA with old CA. This way
> it should work for clients either with old or new CA in configuration files.
>
> I can't manage server to send more than one certificate to the client. It seems that multiple certificates in --cert directive are supported only on client
> side. Am I missing something, is there a way to push multiple certificates from server? If there isn't a way currently, are there any protocol limitations which allows only one certificate to be sent?
>

it's possible to send a stacked CA certificate (i.e. server certificate 
and intermediate CA cert) from server to the client. We use this in 
production, and it is done by simply stacking (cat'ing) the server cert 
and intermediary CA cert file into a single pem file. The intermediary 
CA is verified using the client-side ca.crt file and the server cert is 
signed by the intermediary CA.
I'm not sure what would happen if you stick two CA certs into the file, 
however.
If this does not work: when looking thru the openssl s_server code I see 
a -dcert option which does something similar - looks like it would be 
trivial to add to OpenVPN.

JM2CW,

JJK


