From: tincanteksup <tincanteksup@...277...>
References: <d9c75727-f242-4c8a-3bfc-006e01629716@...277...>
Message-ID: <93fe5956-7978-a5bf-7202-cef16163db97@...277...>
Date: Sun, 27 May 2018 16:14:39 +0100
MIME-Version: 1.0
In-Reply-To: <d9c75727-f242-4c8a-3bfc-006e01629716@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [openvpn-devel] Use --ec-curve
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is almost certain to be the same problem as reported here:
https://community.openvpn.net/openvpn/ticket/963


On 24/05/18 13:46, tincanteksup wrote:
> I have come across the use of --ec-curve on the Forum a couple of times
> but, as it is undocumented and does not appear to work, I did not pay
> that much attention ..
> 
> Now, it turns out that --ec-curve is supported by current release v246,
> so I decided to look more closely at the problem.
> 
> The short version of this thread is that, from what I can test, only
> openssl-1.0.2o can actually connect to a server using any other curve 
> than secp384r1.
> 
> In this example only the openssl version is changed, only one client
> cert is used for both tests.
> 
> server openvpn-2.4.6 openssl-1.1.0h uses --ec-curve brainpoolP384r1
> 
> client openvpn-2.4.6 openssl-1.1.0h cannot connect
> "SSL routines:tls_post_process_client_hello:no shared cipher"
> 
> client openvpn-2.4.6 openssl-1.0.2o *can* connect
> "Control Channel: TLSv1.2, cipher TLSv1/SSLv3 ECDHE-ECDSA-AES256-
> GCM-SHA384, 384 bit EC, curve: brainpoolP384r1"
> 
> The key detail, which drew my attention, is that a v246 server using 
> ossl11x can send the TLS cipher information but the same version of
> ovpn/ossl cannot receive (or setup) that cipher.  Where as a client
> using ovpn246/ossl192o can do this ..

This should obviously read: ovpn246/ossl*102o*


> 
> As --ec-curve remains undocumented I presume that is because its
> implementation is not yet completed ? So I decided to send this email
> for confirmation or, if this problem is not known, to inform you of it.
> 
> Thanks
> tct

