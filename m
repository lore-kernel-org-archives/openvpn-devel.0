From: chantra <chantra@...1258...>
Content-Type: multipart/mixed; boundary="=-kF5DNiXO7gr2dJuYDVNu"
Date: Wed, 26 Aug 2009 12:56:22 +0200
Message-Id: <1251284182.4302.85.camel@...1259...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN with LDAP+TLS authentication runs into file
	exhaustion
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=-kF5DNiXO7gr2dJuYDVNu
Content-Type: multipart/alternative; boundary="=-58iHoN3Dnipa2jJPOYGX"

--=-58iHoN3Dnipa2jJPOYGX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,


This issue is happening on both :
* debian etch   openvpn 2.0.9-4etch1  libpam-ldap 180-1.7
* debian lenny openvpn 2.1~rc11-1  libpam-ldap 184-4.2

Issue is only happening when LDAP is used with TLS support. On every
authentication, a file handle to /dev/urandom is created but never
released even after the dynamic library was closed with dlclose .

>From
http://openvpn.net/index.php/open-source/documentation/change-log/71-21-change-log.html :

        * auth-pam change:  link with -lpam rather than dlopen (Roy
        Marples).

so it seems that some changes were done to the auth backend, but still
the same issue is happeing. 




Because the handle to /dev/urandom is never released, after some times
the service had been running, users will fail to authentication because
the backend is not able to open new file handles on /dev/urandom.
In [4] or [5] you can see how the number of opened /dev/urandom files
increase while running a script that fails to authenticate as a wrong
username/password were given.

So, basically, an authorized user could kindda DoS the service by
providing fake user/password .


the openvpn logs will output when the issue happens:


        Apr 15 08:45:40 myhost openvpnconf[6581]: src.ip:srcport CRL
        CHECK
        OK: /C=county/ST=state/L=location/O=organisation/CN=commun.name/emailAddress=email@...1113...
        Apr 15 08:45:40 myhost openvpnconf[6581]: src.ip:srcport VERIFY
        OK:
        depth=1, /C=county/ST=state/L=location/O=organisation/CN=commun.name/emailAddress=email@...1113...
        Apr 15 08:45:40 myhost openvpnconf[6581]: src.ip:srcport CRL
        CHECK
        OK: /C=country/ST=state/O=organisation/CN=commun_name/emailAddress=email@...1113...
        Apr 15 08:45:40 myhost openvpnconf[6581]: src.ip:srcport VERIFY
        OK:
        depth=0, /C=country/ST=state/O=organisation/CN=commun_name/emailAddress=email@...1113...
        Apr 15 08:45:41 myhost openvpn[6574]: PAM unable to
        dlopen(/lib/security/pam_ldap.so)
        Apr 15 08:45:41 myhost openvpn[6574]: PAM
        [dlerror: /lib/security/pam_ldap.so: cannot open shared object
        file: Too many open files]
        Apr 15 08:45:41 myhost openvpn[6574]: PAM adding faulty
        module: /lib/security/pam_ldap.so
        Apr 15 08:45:41 myhost openvpnconf[6581]: src.ip:srcport
        PLUGIN_CALL:
        POST /usr/lib/openvpn/openvpn-auth-pam.so/PLUGIN_AUTH_USER_PASS_VERIFY status=1
        Apr 15 08:45:41 myhost openvpnconf[6581]: src.ip:srcport
        PLUGIN_CALL: plugin function PLUGIN_AUTH_USER_PASS_VERIFY failed
        with status 1: /usr/lib/openvpn/openvpn-auth-pam.so
        Apr 15 08:45:41 myhost openvpnconf[6581]: src.ip:srcport TLS
        Auth Error: Auth Username/Password verification failed for peer
        Apr 15 08:45:44 myhost openvpnconf[6581]: src.ip:srcport Control
        Channel: TLSv1, cipher TLSv1/SSLv3 DHE-RSA-AES256-SHA, 1024 bit
        RSA
        Apr 15 08:45:44 myhost openvpnconf[6581]: src.ip:srcport
        [common_name] Peer Connection Initiated with src.ip:srcport
        Apr 15 08:45:44 myhost openvpnconf[6581]: src.ip:srcport PUSH:
        Received control message: 'PUSH_REQUEST'
        Apr 15 08:45:44 myhost openvpnconf[6581]: src.ip:srcport SENT
        CONTROL [common_name]: 'AUTH_FAILED' (status=1)



How to Reproduce:
==========
Here is my openvpn auth set up:

        $ cat /etc/pam.d/openvpn 
        account required pam_ldap.so config=/etc/openvpn/pam_ldap.conf
        auth  required pam_ldap.so config=/etc/openvpn/pam_ldap.conf
        password required pam_ldap.so config=/etc/openvpn/pam_ldap.conf
        session required pam_ldap.so config=/etc/openvpn/pam_ldap.conf
        
        $ grep -v '^#' /etc/openvpn/pam_ldap.conf  | grep -v '^$'
        base ou=Users,dc=somain,dc=com
        uri ldap://ldap.domain.com
        ldap_version 3
        pam_login_attribute uid
        pam_groupdn cn=vpn,ou=Groups,dc=domain,dc=com
        pam_member_attribute member
        pam_password crypt
        ssl start_tls
        tls_checkpeer no


* check number of urandom file handle opened:

        $ sudo lsof -p `ps -u root | grep openvpn | cut -f1 -d' '` |
        grep urandom | wc -l

* connect to the service and confirm that there is one more handle
opened.
* disconnect from service. file handle is still there.


Workaround:
=======
A quick workaround is to restart openvpn service once everyday ( might
depend on the service usage though).


Some attempt to understand the issue:
=======================
In the attached program, it seems that the LDAP ressource is not fully
released after calling ldap_unbind .

Looping over the connection/disconnection proves that the ldp pointer is
allocated at the same location, so I wonder if in that case, the LDAP
resource is re-used over and over (thus reusing the same /dev/urandom
file handle) while in the dlopen/dlclose case a fully new allocated TLS
env is created.

A while back, I logged [1] and [2] against openldap and pam_ldap as I
thought issue could have been in the underlying libs. But lately, I have
set up VsFTPd with pam-ldap+TLS auth and the issue is not happening in
that implementation although the settings are pretty similar.
[3] seems to contain the auth part in vsf_sysdep_check_auth() 'round
line 323 .
 
Could that be of any use? Would that solve this issue?

Cheers,

chantra

[1] http://www.openldap.org/lists/openldap-software/200904/msg00072.html
[2] http://bugzilla.padl.com/show_bug.cgi?id=395
[3]
ftp://vsftpd.beasts.org/users/cevans/untar/vsftpd-2.2.0/sysdeputil.c 
[4] http://www.megaupload.com/?d=94M1OYL0 (.ogg )
[5] http://www.megaupload.com/?d=E2NMD2I6   (.avi )


!DSPAM:4a9514d890406079588618!

--=-58iHoN3Dnipa2jJPOYGX
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.26.0">
</HEAD>
<BODY>
Hi all,<BR>
<BR>
<BR>
This issue is happening on both :<BR>
* debian etch&nbsp;&nbsp; openvpn 2.0.9-4etch1&nbsp; libpam-ldap 180-1.7<BR>
* debian lenny openvpn 2.1~rc11-1&nbsp; libpam-ldap 184-4.2<BR>
<BR>
Issue is only happening when LDAP is used with TLS support. On every authentication, a file handle to /dev/urandom is created but never released even after the dynamic library was closed with dlclose .<BR>
<BR>
&gt;From <A HREF="http://openvpn.net/index.php/open-source/documentation/change-log/71-21-change-log.html">http://openvpn.net/index.php/open-source/documentation/change-log/71-21-change-log.html</A> :<BR>
<BLOCKQUOTE>
    * auth-pam change:&nbsp; link with -lpam rather than dlopen (Roy Marples).<BR>
</BLOCKQUOTE>
so it seems that some changes were done to the auth backend, but still the same issue is happeing. 
<PRE>


</PRE>
Because the handle to /dev/urandom is never released, after some times the service had been running, users will fail to authentication because the backend is not able to open new file handles on /dev/urandom.<BR>
In [4] or [5] you can see how the number of opened /dev/urandom files increase while running a script that fails to authenticate as a wrong username/password were given.<BR>
<BR>
So, basically, an authorized user could kindda DoS the service by providing fake user/password .<BR>
<BR>
<BR>
the openvpn logs will output when the issue happens:<BR>
<BR>
<BLOCKQUOTE>
    Apr 15 08:45:40 myhost openvpnconf[6581]: src.ip:srcport CRL CHECK OK: /C=county/ST=state/L=location/O=organisation/CN=commun.name/emailAddress=<A HREF="mailto:email@...1113...">email@...1113...</A><BR>
    Apr 15 08:45:40 myhost openvpnconf[6581]: src.ip:srcport VERIFY OK: depth=1, /C=county/ST=state/L=location/O=organisation/CN=commun.name/emailAddress=<A HREF="mailto:email@...1113...">email@...1113...</A><BR>
    Apr 15 08:45:40 myhost openvpnconf[6581]: src.ip:srcport CRL CHECK OK: /C=country/ST=state/O=organisation/CN=commun_name/emailAddress=<A HREF="mailto:email@...1113...">email@...1113...</A><BR>
    Apr 15 08:45:40 myhost openvpnconf[6581]: src.ip:srcport VERIFY OK: depth=0, /C=country/ST=state/O=organisation/CN=commun_name/emailAddress=<A HREF="mailto:email@...1113...">email@...1113...</A><BR>
    Apr 15 08:45:41 myhost openvpn[6574]: PAM unable to dlopen(/lib/security/pam_ldap.so)<BR>
    Apr 15 08:45:41 myhost openvpn[6574]: PAM [dlerror: /lib/security/pam_ldap.so: cannot open shared object file: Too many open files]<BR>
    Apr 15 08:45:41 myhost openvpn[6574]: PAM adding faulty module: /lib/security/pam_ldap.so<BR>
    Apr 15 08:45:41 myhost openvpnconf[6581]: src.ip:srcport PLUGIN_CALL: POST /usr/lib/openvpn/openvpn-auth-pam.so/PLUGIN_AUTH_USER_PASS_VERIFY status=1<BR>
    Apr 15 08:45:41 myhost openvpnconf[6581]: src.ip:srcport PLUGIN_CALL: plugin function PLUGIN_AUTH_USER_PASS_VERIFY failed with status 1: /usr/lib/openvpn/openvpn-auth-pam.so<BR>
    Apr 15 08:45:41 myhost openvpnconf[6581]: src.ip:srcport TLS Auth Error: Auth Username/Password verification failed for peer<BR>
    Apr 15 08:45:44 myhost openvpnconf[6581]: src.ip:srcport Control Channel: TLSv1, cipher TLSv1/SSLv3 DHE-RSA-AES256-SHA, 1024 bit RSA<BR>
    Apr 15 08:45:44 myhost openvpnconf[6581]: src.ip:srcport [common_name] Peer Connection Initiated with src.ip:srcport<BR>
    Apr 15 08:45:44 myhost openvpnconf[6581]: src.ip:srcport PUSH: Received control message: 'PUSH_REQUEST'<BR>
    Apr 15 08:45:44 myhost openvpnconf[6581]: src.ip:srcport SENT CONTROL [common_name]: 'AUTH_FAILED' (status=1)<BR>
</BLOCKQUOTE>
<BR>
<BR>
How to Reproduce:<BR>
==========<BR>
Here is my openvpn auth set up:<BR>
<BLOCKQUOTE>
    $ cat /etc/pam.d/openvpn <BR>
    account required pam_ldap.so config=/etc/openvpn/pam_ldap.conf<BR>
    auth&nbsp; required pam_ldap.so config=/etc/openvpn/pam_ldap.conf<BR>
    password required pam_ldap.so config=/etc/openvpn/pam_ldap.conf<BR>
    session required pam_ldap.so config=/etc/openvpn/pam_ldap.conf<BR>
    <BR>
    $ grep -v '^#' /etc/openvpn/pam_ldap.conf&nbsp; | grep -v '^$'<BR>
    base ou=Users,dc=somain,dc=com<BR>
    uri ldap://ldap.domain.com<BR>
    ldap_version 3<BR>
    pam_login_attribute uid<BR>
    pam_groupdn cn=vpn,ou=Groups,dc=domain,dc=com<BR>
    pam_member_attribute member<BR>
    pam_password crypt<BR>
    ssl start_tls<BR>
    tls_checkpeer no<BR>
</BLOCKQUOTE>
<BR>
* check number of urandom file handle opened:<BR>
<BLOCKQUOTE>
    $ sudo lsof -p `ps -u root | grep openvpn | cut -f1 -d' '` | grep urandom | wc -l<BR>
</BLOCKQUOTE>
* connect to the service and confirm that there is one more handle opened.<BR>
* disconnect from service. file handle is still there.<BR>
<BR>
<BR>
Workaround:<BR>
=======<BR>
A quick workaround is to restart openvpn service once everyday ( might depend on the service usage though).<BR>
<BR>
<BR>
Some attempt to understand the issue:<BR>
=======================<BR>
In the attached program, it seems that the LDAP ressource is not fully released after calling ldap_unbind .<BR>
<BR>
Looping over the connection/disconnection proves that the ldp pointer is allocated at the same location, so I wonder if in that case, the LDAP resource is re-used over and over (thus reusing the same /dev/urandom file handle) while in the dlopen/dlclose case a fully new allocated TLS env is created.<BR>
<BR>
A while back, I logged [1] and [2] against openldap and pam_ldap as I thought issue could have been in the underlying libs. But lately, I have set up VsFTPd with pam-ldap+TLS auth and the issue is not happening in that implementation although the settings are pretty similar.<BR>
[3] seems to contain the auth part in vsf_sysdep_check_auth() 'round line 323 .<BR>
 <BR>
Could that be of any use? Would that solve this issue?<BR>
<BR>
Cheers,<BR>
<BR>
chantra<BR>
<BR>
[1] <A HREF="http://www.openldap.org/lists/openldap-software/200904/msg00072.html">http://www.openldap.org/lists/openldap-software/200904/msg00072.html</A><BR>
[2] <A HREF="http://bugzilla.padl.com/show_bug.cgi?id=395">http://bugzilla.padl.com/show_bug.cgi?id=395</A><BR>
[3] <A HREF="ftp://vsftpd.beasts.org/users/cevans/untar/vsftpd-2.2.0/sysdeputil.c">ftp://vsftpd.beasts.org/users/cevans/untar/vsftpd-2.2.0/sysdeputil.c</A> <BR>
[4] <A HREF="http://www.megaupload.com/?d=94M1OYL0">http://www.megaupload.com/?d=94M1OYL0</A> (.ogg )<BR>
[5] <A HREF="http://www.megaupload.com/?d=E2NMD2I6">http://www.megaupload.com/?d=E2NMD2I6</A>&nbsp;&nbsp; (.avi )

!DSPAM:4a9514d890406079588618!

</BODY>
</HTML>



--=-58iHoN3Dnipa2jJPOYGX--

--=-kF5DNiXO7gr2dJuYDVNu
Content-Disposition: attachment; filename="start_tls.c"
Content-Type: text/x-csrc; name="start_tls.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

/*
* compile with
* gcc -o start_tls start_tls.c -lldap
* ./start_tls ldap://myldaphost 10
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <ldap.h>
#include <unistd.h>
#include <sys/types.h>




void
ldap_pvt_tls_destroy( void );

void usage(const char *name){
  fprintf(stderr, "USAGE: %s ldap://host [N]\n\tN:\tNumber of connection to create (default: 1)\n", name);
}

int main(int argc, char **argv){
  char uri[BUFSIZ];
  char cmdline[BUFSIZ];
  LDAP *ldp;
  int rc;
  int ldap_version = 3;
  LDAPControl *serverctrls;
  LDAPControl *clientctrls;
  int nbconn = 1;
  int i;

  if(argc < 2){
    usage(argv[0]);
    exit(1);
  }
  if( argc == 3 ){
    nbconn = atoi(argv[2]);
  }

  strcpy(uri, argv[1]);
  sprintf(cmdline, "sudo lsof -p %d | grep random", getpid() );

  for(i = 0; i < nbconn; i++){
    ldp = NULL;
    serverctrls = clientctrls = NULL;
    fprintf(stdout, "\n\n<<<<<<<<<<<< Connection attempt #%d   >>>>>>>>>\n\n", i );
    rc = ldap_initialize(&ldp, uri);
    if(rc != LDAP_SUCCESS){
      fprintf(stderr, "ERROR: ldap_initialize returned (%d) \"%s\" : %s\n", rc, ldap_err2string(rc), strerror(errno));
      exit(1);
    }
    rc = ldap_set_option(ldp, LDAP_OPT_PROTOCOL_VERSION, &ldap_version);
    if(rc != LDAP_OPT_SUCCESS){
      fprintf(stderr, "ERROR: ldap_set_option returned (%d) \"%s\"\n", rc, ldap_err2string(rc));
      exit(1);
    }


    fprintf(stdout, "\t\t******\n");
    fprintf(stdout, "opened urandom files before ldap_start_tls_s:\n");
    system(cmdline);
    fprintf(stdout, "\t\t******\n");
    rc = ldap_start_tls_s(ldp, NULL, NULL);//&serverctrls, &clientctrls);
    if(rc != LDAP_SUCCESS){
      fprintf(stderr, "ERROR: ldap_start_tls_s returned (%d) \"%s\"\n", rc, ldap_err2string(rc));
      exit(1);
    }
    fprintf(stdout, "Successfully started ldap_start_tls_s\n");

    fprintf(stdout, "\tLDAP pointer\t%p\n", ldp);

    fprintf(stdout, "\t\t******\n");
    fprintf(stdout, "opened urandom files after ldap_start_tls_s:\n");
    system(cmdline);
    fprintf(stdout, "\t\t******\n");

    //rc = ldap_unbind_ext_s(ldp, &serverctrls, &clientctrls);
    rc = ldap_unbind_s(ldp);
    if( rc != LDAP_SUCCESS ){
      fprintf(stderr, "ERROR: ldap_unbind_ext_s returned (%d) \"%s\"\n", rc, ldap_err2string(rc));
      exit(1);
    }
    fprintf( stdout, "Successfully unbound\n" );
    fprintf(stdout, "\t\t******\n");
    fprintf(stdout, "opened urandom files after ldap_unbind_ext_s:\n");
    system(cmdline);
    fprintf(stdout, "\t\t******\n");
  }
/*
  no effect
  ldap_pvt_tls_destroy();
*/
  fprintf(stdout, "%s\n", cmdline);
  sleep(100);
  exit(0);
}


--=-kF5DNiXO7gr2dJuYDVNu--



