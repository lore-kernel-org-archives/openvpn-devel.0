Message-ID: <571A0FEA.9060000@...1147...>
Date: Fri, 22 Apr 2016 13:50:02 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <CAP=zTkOpzBtS05aN0XmdtX+DJS-owGaSK-qHXEA2vwsSO_NCjg@...278...>
In-Reply-To: <CAP=zTkOpzBtS05aN0XmdtX+DJS-owGaSK-qHXEA2vwsSO_NCjg@...278...>
Subject: Re: [Openvpn-devel] OpenSSL connect and disconnect calls
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
To: Shubham Chauhan <shubham13099@...2124...>, openvpn-devel@lists.sourceforge.net

Hi,

On 22/04/16 10:16, Shubham Chauhan wrote:
> Hello,
>
> I was going through the codebase, and found myself a bit confused. I 
> wanted to customize some functionalities and run some tests
>
> I was specifically looking for the methods where we start (performing 
> the handshake) and end an OpenSSL session.
>
> How and where are the OpenSSL calls like the SSL_connect(), 
> SSL_SESSION_free(), SSL_shutdown(),  SSL_free(), implemented?
>
> I am following openvpn's release/2.3 branch on github: 
> https://github.com/openvpn/openvpn/tree/release/2.3
>
all openssl code is concentrated in ssl_openssl.c and ssl_verify_openssl.c.
However, OpenVPN is not a "true" SSL application so you won't find 
SSL_connect or SSL_shutdown - connections are established in a different 
manner, as OpenVPN normally runs over UDP and SSL_connect() and friends 
don't like that.

HTH,

JJK


