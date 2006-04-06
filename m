FROM: postmaster@...604...
Subject: [Err] [Openvpn-devel] Re: [PATCH] Enable compliation under Darwin
Content-Transfer-Encoding: 8bit
Mime-Version: 1.0
Content-Type: multipart/report; report-type=delivery-status;
	boundary="1144249457.26329.nexg.q0"
Message-ID: <E1FROzB-0003lA-5F@...556...>
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
Date: Thu Apr  6 00:33:05 2006
To: openvpn-devel@lists.sourceforge.net

This is a multipart MIME message.

--1144249457.26329.nexg.q0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Transmit Report:

iryna7@...604...���� ���� ������ 3�� ���������� ��������������.
(���� ���� : 550 <iryna7@...604...>: Recipient address rejected: User unknown in local recipient table(211.232.190.7))

<����> ���� ������ ���� ����
User unknown       :������ ������ �������� �������� ����
Socket connect fail:���� ���� ������ ���� ����
DATA write fail    :���� ���� ������ ������ ���� ����
DATA reponse fail  :���� ���� ���������� ������ ���� ����

--1144249457.26329.nexg.q0
Content-type: message/delivery-status

Reporting-MTA: dns; nexg.net

Final-Recipient: rfc822;iryna7@...604...
Diagnostic-Code: smtp; 550 error - <iryna7@...604...>: Recipient address rejected: User unknown in local recipient table(211.232.190.7)
Action: failed
Status: 5.0.0

--1144249457.26329.nexg.q0
Content-Type: message/rfc822
Content-Transfer-Encoding: 8bit

X-MF: BNDR=NULL,Date=0,IPR=3.0,DIP=FAIL-DNS,SPF=0,RcvdCnt=5
X-HELO: ehlo lists-outbound.sourceforge.net
X-RECEIVED-IP: 66.35.250.225
X-MAIL-FROM: openvpn-devel-admin@lists.sourceforge.net
Message-ID: <4433CAD4.50807@...601...>
From: Johnny Lam <jlam@...601...>
Reply-To: openvpn-devel@lists.sourceforge.net
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Roy Marples <uberlord@...594...>
Cc: openvpn-devel@lists.sourceforge.net
References: <200604051130.00196.uberlord@...594...>
In-Reply-To: <200604051130.00196.uberlord@...594...>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam Filtering performed by sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	Report problems to http://sf.net/tracker/?func=add&group_id=1&atid=200001
Subject: [Openvpn-devel] Re: [PATCH] Enable compliation under Darwin
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
X-Original-Date: Wed, 05 Apr 2006 09:49:08 -0400
Date: Wed, 05 Apr 2006 09:49:08 -0400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Roy Marples wrote:
> --- openvpn-2.0.4/plugin/down-root/Makefile.orig	2005-11-02 20:25:40.000000000 +0100
> +++ openvpn-2.0.4/plugin/down-root/Makefile	2005-11-02 20:31:53.000000000 +0100
> @@ -7,11 +7,22 @@
>  
>  CC_FLAGS=-O2 -Wall
>  
> +ifeq ($(USERLAND),Darwin)
> +	LIBNAME=dylib
> +else
> +	LIBNAME=so
> +endif
> +
> +lib : down-root.$(LIBNAME)
> +
>  down-root.so : down-root.o
>  	gcc ${CC_FLAGS} -fPIC -shared -Wl,-soname,openvpn-down-root.so -o openvpn-down-root.so down-root.o -lc
>  
> +down-root.dylib : down-root.o
> +	gcc ${CC_FLAGS} -dynamiclib -install_name openvpn-down-root.dylib -o openvpn-down-root.dylib down-root.o -lc
> +
>  down-root.o : down-root.c
>  	gcc ${CC_FLAGS} -fPIC -c ${INCLUDE} down-root.c
>  
>  clean :
> -	rm -f *.o *.so
> +	rm -f *.o *.so *.dylib

According to the Fink porting documents[1], this is not the right way to 
link loadable modules on Mac OS X.  The module should properly end with 
".so", and the compiler flags should include "-bundle" and not 
"-dynamiclib", which should only be used when linking a shared library.

[1] http://fink.sf.net/doc/porting/shared.php?phpLang=en#lib-and-mod

	Cheers,

	-- Johnny Lam <jlam@...601...>


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--1144249457.26329.nexg.q0--
