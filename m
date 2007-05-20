Date: Mon, 21 May 2007 01:11:31 +0200
From: sithglan@...162...
Message-ID: <20070520231131.GB19461@...172...>
References: <20070516135709.GE26428@...172...>
	<20070516145917.GC36293@...1026...>
MIME-Version: 1.0
In-Reply-To: <20070516145917.GC36293@...1026...>
Subject: Re: [Openvpn-devel] Smartcard Authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Jochen Kaiser <Jochen.Kaiser@...1025...>
Cc: openvpn devel <openvpn-devel@lists.sourceforge.net>, Michael Gernoth <simigern@...172...>

Hello Jochen,

> Just visit me in my office on friday morning and I can handover you
> one or two for a test. :-) )

thanks a lot for the offer. I used one of your tokens under Linux with openct
and opensc/openct. Tomorrow I am going to do a few tests with Windows.

Linux:
apt-get install opensc openct ...

/etc/opensc/opensc.conf:
        card_atr 3b:f2:18:00:02:c1:0a:31:fe:58:c8:09:75 {
                driver = "cardos";
                type = "1002";
        }

openssl genrsa -out key 1024
openssl req -new -key key -out tg.csr
pkcs15-init -ECT
pkcs15-init -PT -a 1 -l etoken -v
pkcs15-init -S key -a 1 -u sign,decrypt --split-key
# Sign from CA
pkcs15-init -X tg-signed.crt -v -a 1

pkcs11-providers /usr/lib/opensc/opensc-pkcs11.so
pkcs11-slot-type "label"
pkcs11-slot "OpenSC Card (etoken)"
pkcs11-id-type "subject"
pkcs11-id "/C=DE/ST=Bayern/L=Erlangen/..."

I got ssh-agent also working. At the moment I am only able to use 1024
bit RSA keys under Linux. ssh-agent and openvpn doesn't work at the same
time. :-( It seems that OpenVPN keeps the connection open and blocks
ssh-agent from doing anything with the smart-card.

        Thomas

