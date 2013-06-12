Message-ID: <51B8EFB5.8030008@...515...>
Date: Wed, 12 Jun 2013 16:01:25 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <51B8CE21.6080203@...515...> <51B8E34C.5090400@...1227...>
In-Reply-To: <51B8E34C.5090400@...1227...>
Subject: Re: [Openvpn-devel] OpenVPN Versioning
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On 12/06/2013 15:08, Arne Schwabe wrote:
> Am 12.06.13 21:38, schrieb James Yonan:
>
> About finding out which cipher client and server use. I am not really
> familiar with this code so forgive my stupid question. TLS somehow also
> does this "select the best cipher to use" dance. Why can't we use the
> TLS mechanism but have to use our own IV_CIPHER?

TLS includes a handshake mechanism for TLS version and ciphersuite 
selection.  In TLS, a single ciphersuite specifies a set of cipher, 
mode, keysize, MAC digest, etc., while in OpenVPN the cipher and HMAC 
digest are separately selected by cipher and auth directives.

Historically, OpenVPN has never implemented any interaction between the 
TLS ciphersuite selection and the cipher/auth selection for the OpenVPN 
protocol -- they are completely decoupled from one another, so using TLS 
negotiation isn't going to have any effect on OpenVPN cipher/auth.

But you raise an interesting point that we might want to explore, i.e. 
looking at the TLS ciphersuite that ends up getting negotiated, and 
extract the cipher/auth directive from that since you know it will be 
consistent on both client and server.

>> Suppose I want to put this directive in the config files I distribute to
>> clients, but have it be ignored by older clients that don't recognize
>> it.  I could do this as follows on the client:
>>
>>     setenv opt tls-version-min 1.2
> I suppose this a good idea too also support older client. I would to
> *additionally* add a way to support this in a nicer way for future
> release. Like also adding an option
>
> ignore-unknown-options tls-version new-cool-option
>
> so newer can some day can still be written with having to use "setenv opt"

Sure, that makes sense.

> Loosly related this would also allow to give use a "default" set of
> options that can be ignored (ip-win32 on *nix)

Deciding whether or not to ignore options is tricky.  With the new 3.0 
core, it was necessary to ignore some options because they are simply 
not implemented, and raising an error for every unimplemented option 
would make it very difficult upgrade to 3.0 in a way that maintains 
reasonable config file compatibility with 2.x.

So the approach I took for 3.0 was to only raise an error on 
unimplemented options where ignoring the option might compromise 
security.  Initially tls-remote fell under this category, but it has 
since been implemented in the 3.0 core.

James

