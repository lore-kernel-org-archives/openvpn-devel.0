Message-ID: <4D063404.4050208@...1147...>
Date: Mon, 13 Dec 2010 15:56:04 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4D021744.7010307@...515...> <4D060C34.7050801@...1147...>
	<BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E418F@...1436...>
In-Reply-To: <BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E418F@...1436...>
Content-Type: multipart/alternative;
	boundary="------------040106080900060200030703"
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (9th Dec 2010)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Adriaan de Jong <dejong@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------040106080900060200030703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adriaan,

Adriaan de Jong wrote:
>   
>> -----Original Message-----
>> From: Jan Just Keijser [mailto:janjust@...1147...]
>> Hi Samuli, David, list,
>>
>> What some people get confused about is a stacked certificate vs a
>> certificate chain: OpenVPN only supports stacked CA certificates,
>> meaning that any of the certs present in the stacked file are
>> considered
>> trusted.
>> What some people want is a certificate chain, like some websites use:
>> the website has a server certificate signed by a sub-CA which in turn
>> is
>> signed by Verisign. The webserver sends the entire chain (server cert +
>> sub-CA cert + verisign cert) to the client for verification. That way
>> the client only needs the Verisign cert to trust a particular website
>> (the Verisign CA cert is installed in most browser by default). OpenVPN
>> does not support this at the moment. It would require changing
>>   SSL_CTX_use_certificate()
>> to
>>   SSL_CTX_use_certificate_chain()
>> to ensure that the entire certificate chain is sent to the remote end
>> (client or server).
>>     
>
> I think SSL_CTX_use_certificate_chain_file() is actually used when loading the certificate from a separate cert file. It's just slightly confusing due to the fact that it is loaded twice:
>
> - SSL_CTX_use_certificate_file is used here:
> http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=ssl.c;h=a1268ac2a9291dc1512fa28e3ab4efc65085c952;hb=HEAD#l1639
>
> - SSL_CTX_use_certificate_chain_file is used here:
>   http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=ssl.c;h=a1268ac2a9291dc1512fa28e3ab4efc65085c952;hb=HEAD#l1738
>
> I'm not entirely sure whether I'm right, and why things are done this way. Does anyone know the reasoning behind this?
>
>   

ah mea culpa - I did not read the rest of the init_ssl function. It does 
seem a bit odd though:

this happens first (2.1.3 code base):
1623           if (!SSL_CTX_use_certificate_file (ctx, 
options->cert_file, SSL_FILETYPE_PEM))
1624             msg (M_SSLERR, "Cannot load certificate file %s", 
options->cert_file);
1625           using_cert_file = true;

so we load the cert and we set 'using_cert_file = true' . Then later:
1721   /* Enable the use of certificate chains */
1722   if (using_cert_file)
1723     {
1724       if (!SSL_CTX_use_certificate_chain_file (ctx, 
options->cert_file))
1725     msg (M_SSLERR, "Cannot load certificate chain file %s 
(SSL_use_certificate_chain_file)", options->cert_file);
1726     }

so the certificate is loaded again but now using _use_certificate_chain 
! It does suggest that you can use certificate chains , however.

I just tested a setup where the client cert is a concatenation of the 
client cert + intermediate CA. The client sends these certs to a server 
which only trusts the "root" CA (i.e. the one that signed the 
intermediate CA to begin with) but I cannot connect. It seems the 
'verify_callback' function does not work with certificate chains (yet) : 
only the top level cert is inspected.

to be continued...

cheers,

JJK









--------------040106080900060200030703
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi Adriaan,<br>
<br>
Adriaan de Jong wrote:
<blockquote
 cite="mid:BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E418F@...1436..."
 type="cite">
  <pre wrap="">
  </pre>
  <blockquote type="cite">
    <pre wrap="">-----Original Message-----
From: Jan Just Keijser [<a class="moz-txt-link-freetext" href="mailto:janjust@...1147...">mailto:janjust@...1147...</a>]
Hi Samuli, David, list,

What some people get confused about is a stacked certificate vs a
certificate chain: OpenVPN only supports stacked CA certificates,
meaning that any of the certs present in the stacked file are
considered
trusted.
What some people want is a certificate chain, like some websites use:
the website has a server certificate signed by a sub-CA which in turn
is
signed by Verisign. The webserver sends the entire chain (server cert +
sub-CA cert + verisign cert) to the client for verification. That way
the client only needs the Verisign cert to trust a particular website
(the Verisign CA cert is installed in most browser by default). OpenVPN
does not support this at the moment. It would require changing
  SSL_CTX_use_certificate()
to
  SSL_CTX_use_certificate_chain()
to ensure that the entire certificate chain is sent to the remote end
(client or server).
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I think SSL_CTX_use_certificate_chain_file() is actually used when loading the certificate from a separate cert file. It's just slightly confusing due to the fact that it is loaded twice:

- SSL_CTX_use_certificate_file is used here:
<a class="moz-txt-link-freetext" href="http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=ssl.c;h=a1268ac2a9291dc1512fa28e3ab4efc65085c952;hb=HEAD#l1639">http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=ssl.c;h=a1268ac2a9291dc1512fa28e3ab4efc65085c952;hb=HEAD#l1639</a>

- SSL_CTX_use_certificate_chain_file is used here:
  <a class="moz-txt-link-freetext" href="http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=ssl.c;h=a1268ac2a9291dc1512fa28e3ab4efc65085c952;hb=HEAD#l1738">http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=ssl.c;h=a1268ac2a9291dc1512fa28e3ab4efc65085c952;hb=HEAD#l1738</a>

I'm not entirely sure whether I'm right, and why things are done this way. Does anyone know the reasoning behind this?

  </pre>
</blockquote>
<br>
ah mea culpa - I did not read the rest of the init_ssl function. It
does seem a bit odd though: <br>
<br>
this happens first (2.1.3 code base):<br>
1623&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!SSL_CTX_use_certificate_file (ctx,
options-&gt;cert_file, SSL_FILETYPE_PEM))<br>
1624&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg (M_SSLERR, "Cannot load certificate file %s",
options-&gt;cert_file);<br>
1625&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; using_cert_file = true;<br>
<br>
so we load the cert and we set 'using_cert_file = true' . Then later:<br>
1721&nbsp;&nbsp; /* Enable the use of certificate chains */<br>
1722&nbsp;&nbsp; if (using_cert_file)<br>
1723&nbsp;&nbsp;&nbsp;&nbsp; {<br>
1724&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!SSL_CTX_use_certificate_chain_file (ctx,
options-&gt;cert_file))<br>
1725&nbsp;&nbsp;&nbsp;&nbsp; msg (M_SSLERR, "Cannot load certificate chain file %s
(SSL_use_certificate_chain_file)", options-&gt;cert_file);<br>
1726&nbsp;&nbsp;&nbsp;&nbsp; } <br>
<br>
so the certificate is loaded again but now using _use_certificate_chain
! It does suggest that you can use certificate chains , however. <br>
<br>
I just tested a setup where the client cert is a concatenation of the
client cert + intermediate CA. The client sends these certs to a server
which only trusts the "root" CA (i.e. the one that signed the
intermediate CA to begin with) but I cannot connect. It seems the
'verify_callback' function does not work with certificate chains (yet)
: only the top level cert is inspected.<br>
<br>
to be continued...<br>
<br>
cheers,<br>
<br>
JJK<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
</body>
</html>

--------------040106080900060200030703--

