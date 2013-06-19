Message-ID: <51C109A2.1080609@...515...>
Date: Tue, 18 Jun 2013 19:30:10 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <51B8CE21.6080203@...515...>
	<1CED409804E2164C8104F9E623B08B9014555DB21A@...1436...>
	<51BB74B2.9020809@...515...> <51BEC19F.7040305@...1435...>
In-Reply-To: <51BEC19F.7040305@...1435...>
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
To: openvpn-devel@lists.sourceforge.net

On 17/06/2013 01:58, Steffan Karger wrote:
> On 06/14/2013 09:53 PM, James Yonan wrote:
>> To get the adaptive versioning behavior in OpenSSL, you have to use
>> SSLv23_server_method() or SSLv23_client_method() and then explicitly
>> disable the versions you don't want to consider, i.e. SSL_OP_NO_SSLv2,
>> SSL_OP_NO_SSLv3, SSL_OP_NO_TLSv1, SSL_OP_NO_TLSv1_1, etc.
>>
> Wow, so SSLv23_{client,server}_method() is the 'wildcard' you need to
> dynamically negotiate the version. Yet it sounds like something
> completely broken that should be avoided at all cost. OpenSSL keeps
> amazing me.

It really shows OpenSSL's age, doesn't it?  But aside from the 
cruftiness, I wouldn't say that it's broken.  It's arguably a more 
flexible mechanism than PolarSSL because it allows you to cherry-pick 
the SSL/TLS versions you want to support, rather than just give a 
min/max range.

>>> Does the change to key_state_ssl_init() do anything?
>>
>> I had to add ssl_flags (containing tls-version-min parameter) to
>> key_state_ssl_init because that seems like the most appropriate place to
>> configure tls-version-min for PolarSSL.
>>
>> For OpenSSL, tls_ctx_set_options is the right place to configure
>> tls-version-min.
>>
> The ssl_flags are already available through the tls session that is
> passed as the fourth parameter. To make this a bit more clear, commit
> b97e2c3 changed the type of session to struct tls session* (see
> https://github.com/OpenVPN/openvpn/commit/b97e2c3c90afdbb1a24bc1357ec6b94d626defcd).

Right, I've rebased the patch against master and now use 
session->opt->ssl_flags

This simplifies the patch because now it's no longer necessary to pass 
ssl_flags to key_state_ssl_init

https://github.com/jamesyonan/openvpn/commit/03a5599202bdc3ba07983dc4efdae387fb8fb436

James

